require "rubygems"
# require 'json'
# require 'rest_client'
# require 'roo'
# require 'RubyXL'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://wwww.google.com"
driver.manage.window.maximize

