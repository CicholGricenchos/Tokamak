Gem::Specification.new do |spec|
  spec.name          = 'tokamak'
  spec.version       = '0.0.1'
  spec.authors       = ['cichol']
  spec.email         = ['cichol@live.cn']

  spec.summary       = ''
  spec.description   = ''

  spec.files         = Dir.glob("lib/**/*.rb") + %w{ tokamak.rb }
  spec.require_paths = ['.']

  spec.add_dependency 'opal'
end