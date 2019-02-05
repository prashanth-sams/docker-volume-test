require 'selenium-webdriver'
require 'rspec/expectations'
require 'byebug'

include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for :remote, :url => "http://0.0.0.0:4444/wd/hub", desired_capabilities: :chrome
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  filename = '/tmp/demo.png'
  file = File.join(filename)

  @driver.get 'http://the-internet.herokuapp.com/upload'
  @driver.find_element(id: 'file-upload').send_keys file
  @driver.find_element(id: 'file-submit').click

  uploaded_file = @driver.find_element(id: 'uploaded-files').text
  puts uploaded_file
end
