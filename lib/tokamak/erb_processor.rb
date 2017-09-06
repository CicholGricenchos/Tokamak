require 'xml'

module Tokamak
  class ErbProcessor
    def initialize template
      @template = template
    end

    def process
      @template.gsub!(/<%=(.+?)%>/, '<ruby-expression>\1</ruby-expression>')
      @template.gsub!(/<%(.+?)%>/, '<ruby-execution>\1</ruby-execution>')
      doc = XML::Parser.string(@template).parse
      process_document doc
    end

    def process_attributes attributes
      result = ['{']
      pairs = []
      attributes.each do |attr|
        if attr.name.match /^on/
          pairs << "'#{attr.name}': " + '`(function(e){#{' + attr.value + '(React::Event.new(`e`))}})`'
        else
          pairs << "'#{attr.name}': '#{attr.value}'"
        end
      end
      "{#{pairs.join(',')}}"
    end

    def process_node node, root = false
      result = []
      if node.children?
        result << (root ? "" : "__ << ") + "React.create_element('#{node.name}', #{process_attributes node.attributes}, "
        result << "[].tap{|__|"
        node.children.reject(&:empty?).each do |child|
          case child.name
          when 'text'
            result << "__ << '#{child.content}'\n"
          when 'ruby-execution'
            result << "#{child.content}\n"
          when 'ruby-expression'
            result << "__ << #{child.content}\n"
          else
            result << (process_node child)
          end
        end
        result << "})"
      else
        case node.name
        when 'text'
          result << "__ << '#{node.content}'\n"
        else
          result << (root ? "" : "__ << ") + "React.create_element('#{node.name}', #{process_attributes node.attributes})\n"
        end
      end
      result.join
    end

    def process_document doc
      process_node doc.child, true
    end

  end
end
