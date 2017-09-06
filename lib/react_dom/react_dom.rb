module ReactDOM
  def self.render element, container, callback
    `ReactDOM.render(#{element}, #{container}, #{callback})`
  end

  def self.unmount_component_at_node container
  end

  def self.find_dom_node component
  end
end