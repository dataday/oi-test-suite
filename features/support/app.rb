require 'openssl'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'addressable/uri'
require 'rest_client'
require 'json'
require 'active_support/core_ext/string'

require_relative 'step_helpers'

# @todo: reinstate RestClient client / server certificate support
# ~ PEM
# ssl_client_cert: OpenSSL::X509::Certificate.new(file),
# ssl_client_key: OpenSSL::PKey::RSA.new(file, pass),
# ssl_ca_file: '/etc/pki/tls/cacert.pem'
# ~ P12
# OpenSSL::PKCS12.new(file, pass)

# Test suite
module TestSuite
  # Application
  class App
    # Step helper mixin
    # @see StepHelpers
    include StepHelpers

    # custom readers
    attr_reader :root, :host, :config
    attr_accessor :endpoint

    # Initialises class
    # @param browser [Symbol] browser name
    # @param session [Hash] session data
    # @return [void]
    def initialize(browser, session)
      if register(browser, session)
        puts '-> SUCCESS: registered suite'
      else
        puts '-> FAILED: registered suite'
      end
    end

    # Checks if environment is supported
    # @param environment [Symbol] environment identifier
    # @return [Boolean] returns true if supported, otherwise false
    def environment?(environment)
      environment.nil? ? false : @config[:environments].include?(environment)
    end

    # Gets current Capybara driver
    # @return [Capybara::Session] current driver
    # @see Capybara::Session#driver
    def driver
      Capybara.current_session.driver
    end

    # Parses URL into default components
    # @param url [String] URL
    # @return [Addressable::URI] URL object
    # @see Addressable::URI#parse
    def parse_url(url)
      Addressable::URI.parse(url)
    end

    private

    # Sets up common configurations and instance variables
    # @param session [Hash] project session options
    # @return [void]
    def setup(session)
      @root = File.expand_path('../../', File.dirname(__FILE__))
      @config = configure(session, "#{@root}/lib")
      @browsers = @config.delete :browsers
      @endpoints = @config.delete :endpoints
      @host = get_host(environment?(session[:env]) ? session[:env].to_sym : :www)
    end

    # Parses JSON file content
    # @param file [String] file path
    # @param symbolize [Boolean] symbolize keys if true, otherwise false
    # @param data [Hash] default empty object
    # @return [Hash] response data
    def parse_json_data(file, symbolize = true, data = {})
      return {} unless File.exist?(file)
      data = IO.read(file)
      data = JSON.parse(data)
      data = symbolize_keys(data) if symbolize == true && data.is_a?(Hash)
      data
    rescue StandardError => e
      puts e
      data
    end

    # Configures application with input and external data
    # @param session [Hash] session options
    # @param config [String] configuration path
    # @return [Hash] response data
    # @see lib/endpoints.json
    # @see lib/services.json
    def configure(session, config)
      data = {}
      %i[services endpoints browsers].each do |key|
        symbolize = key == :services ? false : true
        data.merge!(parse_json_data("#{config}/#{key}.json", symbolize))
      end

      data.merge!(session) if session.is_a?(Hash)
      data
    end

    # Configures Capybara session and driver
    # @param environment [Symbol] environment identifier
    # @param driver [Hash] driver options
    # @param browser [Symbol] browser identifier
    # @return [void]
    # @see Capybara#configure
    # @see Capybara#register_driver
    def configure_capybara(environment, driver, browser)
      options = get_options(browser, driver) || {}

      Capybara.configure do |x|
        x.default_host = @host.to_s
        x.always_include_port = true
        x.default_driver = browser
        x.javascript_driver = browser unless driver[:js].nil?
        x.default_selector = driver[:selector].to_sym unless driver[:selector].nil?
        x.ignore_hidden_elements = false
        x.visible_text_only = false
        x.match = :prefer_exact
        x.run_server = environment
        x.default_max_wait_time = 2
      end

      Capybara.register_driver browser do |app|
        if browser == :poltergeist
          Capybara::Poltergeist::Driver.new(app, options)
        else
          Capybara::Selenium::Driver.new(app, options)
        end
      end

      true
    end

    # Registers driver from session
    # @param session [Hash] session options
    # @param browser [Symbol] browser identifier
    # @return [void]
    def register(browser, session)
      setup(session)
      environment = environment?(@config[:env])
      driver = @browsers.select { |x| x[:name] == browser }.first
      browser = driver[:name].to_sym unless driver[:name].nil?

      return unless driver.is_a?(Hash)
      return unless @host.is_a?(Addressable::URI)

      configure_capybara(environment, driver, browser)
    end

    # Gets host URL
    # @param environment [Symbol] environment identifier
    # @return [Addressable::URI] URL object
    def get_host(environment)
      host = nil
      project = @config[:project].underscore.to_sym

      if @endpoints.include?(project)
        host = @endpoints[project].gsub('$sub', environment.to_s)
      end

      parse_url(host)
    end

    # Gets driver specific configuration options
    # @param browser [Symbol] browser identifier
    # @param driver [Hash] driver options
    # @return [Hash] driver options
    def get_options(browser, driver)
      options = driver[:options] || {}
      case browser
      when :poltergeist
        options
      else
        { browser: browser }
      end
    end
  end
end
