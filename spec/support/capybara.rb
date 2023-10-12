# frozen_string_literal: true

# Capybara.default_driver = :selenium_headless
Capybara.javascript_driver = :rack_test

RSpec.configure do |config|
  # config.before(:each, :js, type: :system) do |example|
  #   driven_by :iphone_6_7_8 if self.class.include?(Capybara::DSL) && example.file_path.include?('mobile')
  # end

  # config.before do |example|
  #   if self.class.include?(Capybara::DSL) && example.file_path.exclude?('mobile')
  #     Capybara.current_driver = :selenium_headless
  #     Capybara.page.driver.browser.manage.window.maximize
  #   end
  # end

  config.before(:each, type: :system) do
    driven_by :selenium_headless
  end
  # config.after do
  #   Capybara.use_default_driver
  # end
end
