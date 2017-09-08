if RUBY_ENGINE == 'opal'
  require 'tokamak'
else
  require 'opal'
  require 'opal-sprockets'
  Opal.append_path File.expand_path('./../../opal', __FILE__).untaint

  require_relative 'tokamak/erb/compiler'
  require_relative 'tokamak/erb/sprockets_processor'
end