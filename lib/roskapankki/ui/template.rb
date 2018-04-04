require "erb"
require 'ostruct'

module Roskapankki
  module UI
    class Template
      def self.render(*args)
        self.new(*args).render
      end

      def initialize(template_name, locals: {})
        @template_name = template_name
        @locals = locals
        @template = File.read(template_path)
      end

      def template_path
        "#{File.dirname(__FILE__)}/views/#{@template_name}.erb"
      end

      def locals
        OpenStruct.new(@locals)
      end

      def binding
        locals.binding
      end

      def render
        ERB.new(@template).result(binding)
      end
    end
  end
end
