require_relative 'lib/appium_capybara/version'

class Gem::Specification
  def remove_zip_files array
    array.reject { |e| File.extname(e).downcase == '.zip' }
  end
end

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.2'

  s.name          = 'appium_capybara'
  s.version       = Appium::Capybara::VERSION
  s.date          = Appium::Capybara::DATE
  s.license       = 'http://www.apache.org/licenses/LICENSE-2.0.txt'
  s.description   = s.summary = 'Enables appium support in Capybara'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['scott.bonebrake@gmail.com', 'code@bootstraponline.com', 'jason.s.carr@gmail.com']
  s.homepage      = 'https://github.com/appium/appium_capybara'
  s.require_paths = ['lib']

  s.add_runtime_dependency 'appium_lib', '>= 9.15.0'
  s.add_runtime_dependency 'capybara', '~> 3.27'

  s.add_development_dependency 'appium_thor', '~> 0.0', '>= 0.0.7'
  s.add_development_dependency 'pry'

  s.files = s.remove_zip_files(`git ls-files`.split("\n"))
end
