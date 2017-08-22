require_relative 'app'

browser = ENV['BROWSER']

@app = app = TestSuite::App.new(
  browser,
  env: ENV['ENV'],
  project: ENV['PROJECT_NAME'],
  cert_path: ENV['CERT'],
  cert_password: ENV['CERT_PASSWORD'],
  http_proxy: ENV['http_proxy'],
  https_proxy: ENV['https_proxy']
)

Before do
  @app = app
end
