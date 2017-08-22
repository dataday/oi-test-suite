# encoding: UTF-8

# general step helpers
module ProjectOneStepHelpers
  # Gets URI with query parameter from label
  # @param label [String] label value
  # @return [String] the resulting path
  def get_path(label)
    case label.strip
    when /^(expired|success|error|complete)$/
      '/modules/newsletter?subscribe=' + Regexp.last_match[1]
    when /^unsubscribe$/
      '/modules/newsletter?unsubscribe=success'
    when /^(en|cy|gd|ga)$/
      '/modules/newsletter?lang=' + Regexp.last_match[1]
    when /^privacy$/
      '/privacy/'
    else
      '/modules/newsletter'
    end
  end

  # Gets CSS selector from name
  # @param name [String] name value
  # @return [String] the CSS selector
  def get_item(name)
    case name.strip
    when /^module$/
      'div.module-newsletter'
    when /^form/
      'form.newsletter'
    when /^(email|title|description|introduction|frequency|expired|error|success|complete|submit|policy)$/
      '.newsletter-' + Regexp.last_match[1]
    when /^unsubscribe$/
      '.newsletter-success'
    when /^terms$/
      'input#tandc'
    when /^related$/
      'input#tandc'
    when /^consent$/
      'input#under_16_consent'
    when /^privacy$/
      '.newsletter-privacy a'
    when /^subscribe$/
      '.newsletter-subscription div p a'
    when /^(success|error|subscription|tandc)$/
      'form.newsletter input#' + Regexp.last_match[1]
    end
  end

  # Gets text from HTML element by type
  # @param item [String] HTML element
  # @param type [String] type of element
  # @return [String] the element's text
  def get_text(item, type)
    text = item[:title] if type == 'field'
    text = item.value if type == 'button'
    text = item.text if type == 'link'
    text
  end

  # Gets service ID from presets
  # @param id [String] ID value
  # @return [String] the ID's value
  # @see lib/services.json
  def get_service(id)
    ids = @app.config[:services]
    ids = ids.invert if ids[id].nil?
    id[id].nil? ? "Add this service ID: #{id}" : ids[id]
  end
end

World(ProjectOneStepHelpers)
