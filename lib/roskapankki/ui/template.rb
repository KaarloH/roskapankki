require "erb"
require "ostruct"

module Roskapankki
  module UI
    class Template
      def self.render(*args)
        self.new(*args).render
      end

      def initialize(template_name, locals: {})
        @template_name = template_name
        @locals = OpenStruct.new(locals)
        @template = File.read(template_path)
      end

      def template_path
        "#{File.dirname(__FILE__)}/views/#{@template_name}.erb"
      end

      def render
        ERB.new(@template).result(@locals.instance_eval { binding })
      end
    end
  end
end
