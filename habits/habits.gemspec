Gem::Specification.new do |s|
  s.name         = "HABITS"
  s.version      = "1.0.0"
  s.author       = "Aaron Wortham"
  s.email        = "wortham.aaron@gmail.com"
  s.homepage     = "http://104.236.107.11"
  s.summary      = "Get information about you streaks and habits"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'habits' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
