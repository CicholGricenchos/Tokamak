module Tokamak
  module Erb
    class SprocketsProcessor < ::Opal::Processor
      self.default_mime_type = 'application/javascript'

      def evaluate(context, locals, &block)
        @data = Tokamak::Erb::Compiler.new(@data).process
        @data = wrap @data, context.logical_path.sub(/^templates\//, '')
        super
      end

      def self.compiler_options
        # otherwise would check current class `attr_accessor`s
        ::Opal::Processor.compiler_options
      end

      def wrap(code, file)
        <<-EOS
          Tokamak::TEMPLATES['#{file}'] = -> {
            #{code}
          }
        EOS
      end

    end
  end
end

if Sprockets.respond_to? :register_transformer
  extra_args = [{mime_type: 'application/javascript', silence_deprecation: true}]
else
  extra_args = []
end

Sprockets.register_engine '.erb', Tokamak::Erb::SprocketsProcessor, *extra_args