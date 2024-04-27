require_relative 'lib/appium_capybara/version'

class Gem::Specification
  def remove_zip_files array
    array.reject { |e| File.extname(e).downcase == '.zip' }
  end
end

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.7'

  s.name          = 'appium_capybara'
  s.version       = Appium::Capybara::VERSION
  s.date          = Appium::Capybara::DATE
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Enables appium support in Capybara'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['fly.49.89.over@gmail.com']
  s.homepage      = 'https://github.com/appium/appium_capybara'
  s.require_paths = ['lib']

  s.add_runtime_dependency 'appium_lib', '~> 12.0.0'
  s.add_runtime_dependency 'capybara', '~> 3.36'

  s.add_development_dependency 'appium_thor', '~> 2.0'

  s.files = s.remove_zip_files(`git ls-files`.split("\n"))
end
