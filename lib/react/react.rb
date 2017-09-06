require_relative 'component'
require_relative 'event'

module React
  def self.create_element type, props = {}, *children
    `React.createElement(#{type.to_n}, #{props.to_n}, #{children.to_n})`
  end
end