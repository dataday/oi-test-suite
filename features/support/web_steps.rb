# encoding: UTF-8

Given(/^I visit a (\w+) page$/) do |type|
  url = get_url(type).to_s
  visit url do
    current_page.should eq url
  end
  puts "--> #{current_url}"
end
