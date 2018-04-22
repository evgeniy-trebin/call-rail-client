# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name    = 'call-rail-client'
  spec.version = '0.0.0'

  spec.author      = 'Eugene Trebin'
  spec.email       = 'evgeniy.trebin@gmail.com'
  spec.description = 'Wrapper for CallRail API'
  spec.summary     = ''
  spec.homepage    = 'https://github.com/evgeniy-trebin/call-rail-client'
  spec.license     = ''

  spec.files      = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.test_files = spec.files.grep(/^spec/)

  spec.add_development_dependency 'activesupport', '~> 5.2'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rest-client', '~> 2.0'
end
# rubocop:enable Metrics/BlockLength
