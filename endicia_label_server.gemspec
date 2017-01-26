require File.expand_path('../lib/endicia_label_server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'endicia_label_server'
  gem.version     = EndiciaLabelServer::Version::STRING
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ['Veeqo']
  gem.email       = ['helpme@veeqo.com']
  gem.homepage    = 'http://github.com/matt423/endicia_label_server'
  gem.summary     = 'Endicia LabelServer'
  gem.description = '''
    Gem for accessing the Endicia Label Server XML API from Ruby
  '''

  gem.license     = 'AGPL'

  gem.required_rubygems_version = '>= 1.3.6'

  gem.add_runtime_dependency 'ox', '~> 2.2', '>= 2.2.0'
  gem.add_runtime_dependency 'excon', '~> 0.45', '>= 0.45.3'
  gem.add_runtime_dependency 'insensitive_hash', '~> 0.3.3'

  gem.files        = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.require_path = 'lib'
end
