Gem::Specification.new do |spec|
  spec.name          = 'tokamak'
  spec.version       = '0.0.1'
  spec.authors       = ['cichol']
  spec.email         = ['cichol@live.cn']

  spec.summary       = ''
  spec.description   = ''

  spec.files         = Dir.glob("lib/**/*.rb") + Dir.glob("opal/**/*.rb")
  spec.require_paths = ['lib']

  spec.add_dependency 'opal', '0.11.0.rc1'
  spec.add_dependency 'opal-sprockets', '0.4.1.0.11.0.rc1.3.1.beta2'
  spec.add_dependency 'libxml-ruby'
end