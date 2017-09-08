require 'native'
require_relative 'react/react'
require_relative 'react_dom/react_dom'

module Tokamak
  TEMPLATES = {}
  COMPONENTS = {}

  def self.component path, &block
    COMPONENTS[path] = Class.new(React::Component, &block)
  end
end