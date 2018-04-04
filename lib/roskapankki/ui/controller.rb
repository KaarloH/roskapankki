require "roskapankki/ui/template"

module Roskapankki
  module UI
    class Controller
      def self.route
        /roskapankki/
      end

      def initialize(request)
        @request = request
      end

      def response
        [200, { 'Content-Type' => 'text/html' }, [render]]
      end

      def render
        Roskapankki::UI::Template.render("bank")
      end
    end
  end
end
