# encoding: UTF-8

# general step helpers
module StepHelpers
  # Gets URI with query parameter from label
  # @param label [String] label value
  # @return [String] the resulting path
  def get_path(label)
    case label.strip
    when /^(cookie|privacy)$/
      '/' + Regexp.last_match[1] + '-policy'
    else
      '/'
    end
  end

  # Gets URL
  # @param label [String] label
  # @return [Hash] data with symbolised keys
  def get_url(label)
    path = get_path(label)
    url = "#{@app.host}#{path}"
    @app.parse_url(url)
  end

  # Symbolises hash keys recursively
  # @param hash [Hash] data
  # @return [Hash] data with symbolised keys
  def symbolize_keys(h)
    case h
    when Hash
      Hash[h.map { |k, v| [k.respond_to?(:to_sym) ? k.to_sym : k, symbolize_keys(v)] }]
    when Enumerable
      h.map { |v| symbolize_keys(v) }
    else
      h
    end
  rescue => e
    puts e
  end
end

World(StepHelpers)
