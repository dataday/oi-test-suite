# encoding: UTF-8

content_regex = /^[\w\.\-\_ ]+/

When(/^I see the (\w+) (button|checkbox|field|link)$/) do |type, input|
  within get_item('module') do
    find get_item(type)
  end
end

When(/^mandatory fields exist$/) do
  within get_item('module') do
    %w[success error].each do |type|
      item = find get_item(type), visible: false
      item.value.should match Regexp.new(/^.+?\?subscribe\=(error|success)$/)
    end
    %w[subscription tandc].each do |type|
      item = find get_item(type), visible: false
      item.value.should match Regexp.new(/^\w+$/)
    end
    %w[email].each do |type|
      item = find get_item(type), visible: true
      item.value.should match ''
    end
  end
end

Then(/^I see a subscription (form)$/) do |type|
  step 'mandatory fields exist'
  within get_item('module') do
    find get_item(type), visible: true
  end
end

# EDITORIAL
Given(/^(.+?) content exists$/) do |type|
  item = get_item(type)
  within get_item('module') do |dom|
    find item, visible: true
  end
end

When(/^the (.+?) text is shown$/) do |type|
  item = get_item(type)
  find item, text: content_regex
end

Then(/^the (.+?) should appear (\w+)$/) do |type, number|
  within get_item('form') do |form|
    node = find :xpath, "./node()/*[#{number.to_i}]"
    node[:class].should eq "module-#{type}"
  end
end

Then(/^the (.+?) should appear before the (.+?) .+?$/) do |type, target|
  type = "module-#{type}"
  target = "module-#{target}"
  within get_item('form') do |form|
    find :xpath, "descendant-or-self::node()[@class='#{target}']/following-sibling::node()[contains(@class, #{type})]"
  end
end

# SUBSCRIPTIONS
Then(/^the (.+?) should appear instead of a form$/) do |type|
  should_not have_css get_item 'form'
  should have_css get_item type
end

# LOCALISATION
When(/^I see the (.+?) (button|field|link) with (.+?)$/) do |type, input, label|
  item = find get_item(type)
  text = get_text(item, input)
  text.should include label
end

# POLICY
When(/^I see the (\w+) checkbox unchecked$/) do |type|
  item = find get_item(type)
  uncheck item[:id]
  item.should_not be_checked
end

And(/^I click the (\w+) .+?$/) do |type|
  item = find get_item(type)
  item.click
end

Then(/^I see the (\w+) checkbox checked$/) do |type|
  item = find get_item(type)
  check item[:id]
  item.should be_checked
end

Then(/^I see the (.+?) page$/) do |type|
  path = get_url(type).path
  current_path.should eq path
end

# SUBMISSIONS
Given(/^I enter '(.+?)' as a (.+?)$/) do |data, type|
  within get_item('form') do |form|
    fill_in 'email', with: data
    item = find get_item type
    item.value.should include data
    puts data
  end
end

When(/^(.+?) data '(.+?)' for (.+?) is submitted$/) do |type, data, group|
  item = find get_item 'subscription'
  item.set(group)

  within get_item('form') do |form|
    fill_in 'email', with: data
    click_on 'Subscribe'
    current_url.should include type
    status_code.should eq 200
  end
end

Then(/^I see the (.+?) checkbox unchecked by default$/) do |type|
  item = find get_item(type)
  item.should_not be_checked
end

Then(/^the (.+?) link takes me to the privacy page$/) do |type|
  item = find get_item(type)
  item[:href].should eq get_url(type).path
end

Then(/^I see the (.+?) message$/) do |type|
  pending # requires JS validation
end
