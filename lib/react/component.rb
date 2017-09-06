module React
  class Component
    include Native

    class << self
      attr_reader :initial_state

      def to_n
        @__class ||= `
          React.createClass({
            displayName: #{name},
            getInitialState: function(){
              this.__component = #{self.new(`this`)}
              return #{initial_state.to_n}
            },
            render: function(){
              return this.__component.$render()
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
    end

    def component_will_mount
    end

    def render
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
  end
end