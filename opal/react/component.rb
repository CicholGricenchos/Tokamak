module React
  class Component
    include Native

    class << self
      attr_reader :initial_state
      attr_accessor :__path

      def to_n
        @__class ||= `
          React.createClass({
            displayName: #{name},
            getInitialState: function(){
              this.__component = #{self.new(`this`)}
              return #{initial_state.to_n}
            },
            render: function(){
              return this.__component.$render_component_template()
            },
            componentWillMount: function(){
              return this.__component.$component_will_mount()
            },
            componentDidMount: function(){
              return this.__component.$component_did_mount()
            },
            componentWillReceiveProps: function(props){
              return this.__component.$component_will_receive_props(#{Native(`props`)})
            },
            shouldComponentUpdate: function(nextProps, nextState){
              return this.__component.$should_component_update(#{Native(`nextProps`)}, #{Native(`nextState`)})
            },
            componentWillUpdate: function(nextProps, nextState){
              return this.__component.$component_will_update(#{Native(`nextProps`)}, #{Native(`nextState`)})
            },
            componentDidUpdate: function(prevProps, prevState){
              return this.__component.$component_did_updade(#{Native(`prevProps`)}, #{Native(`prevState`)})
            },
            componentWillUnmount: function(){
              return this.__component.$component_will_unmount()
            }
          })
        `
      end

      def state hash
        @initial_state ||= {}
        @initial_state.merge!(hash)
      end

      def template path
        @template_path = path
      end

      def template_path
        @template_path ||= __path
      end
    end

    def component_will_mount
    end

    def render_component_template
      instance_exec(&Tokamak::TEMPLATES[self.class.template_path])
    end

    def __scope &block
      prev_scope = @__current_scope
      @__current_scope = []
      instance_exec &block
      result = @__current_scope
      @__current_scope = prev_scope
      result
    end

    def __push value
      @__current_scope << value
    end

    def render component_path, props, children_proc = nil
      component = Tokamak::COMPONENTS[component_path]
      raise "cannot find component by #{component_path}" unless component
      if children_proc
        children = __scope &children_proc
      else
        children = []
      end
      React.create_element(component, props, children)
    end

    def self.inherited base
      path = base.name.gsub('::', '/').gsub(/([a-z])([A-Z])/, '\1_\2').downcase
      Tokamak::COMPONENTS[path] = base
      base.__path = path
    end

    def component_did_mount
    end

    def component_will_receive_props props
    end

    def should_component_update next_props, next_state
    end

    def component_will_update next_props, next_state
    end

    def component_did_updade prev_props, prev_state
    end

    def component_will_unmount
    end

    def set_state state, callback = nil
      `#{@native}.setState(#{state.to_n}, #{callback.to_n})`
    end

    def force_update
    end

    def state
      Native(`#{@native}.state`)
    end

    def state= hash
      `#{@native}.state = #{hash.to_n}`
    end

    def props
      Native(`#{@native}.props`)
    end
  end
end