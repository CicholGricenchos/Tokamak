require_relative 'component'
require_relative 'event'

module React
  def self.create_element type, props = {}, children = []
    `React.createElement.apply(null, #{[type, props, *children].to_n})`
    #`React.createElement(#{type.to_n}, #{props.to_n}, #{children.to_n})`
  end
end