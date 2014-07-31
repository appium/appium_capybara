require_relative 'lib/appium_capybara/common/version'

Gem::Specification.new do |s|
  # 1.8.x is not supported
  s.required_ruby_version = '>= 1.9.3'

  s.name          = 'appium_capybara'
  s.version       = Appium::Capybara::VERSION
  s.date          = Appium::Capybara::DATE
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Enables appium support in Capybara'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['sbonebrake@yammer-inc.com', 'code@bootstraponline.com']
  s.homepage      = 'https://github.com/appium/appium_capybara'
  s.require_paths = ['lib']

  s.add_runtime_dependency 'appium_lib', '~> 4', '>= 4.1.0'
  s.add_runtime_dependency 'capybara', '~> 2.4', '>= 2.4.1'

  s.add_development_dependency 'appium_thor', '~> 0.0', '>= 0.0.6'

  s.files = `git ls-files`.split "\n"
end