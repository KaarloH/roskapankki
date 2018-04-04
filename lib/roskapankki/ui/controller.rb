require "roskapankki/ui/template"

module Roskapankki
  module UI
    class Controller
      attr_reader :request

      def self.route
        /roskapankki/
      end

      def initialize(request)
        @request = request
      end

      def get
        response(Roskapankki::UI::Template.render("bank"))
      end

      def post
        response(nil)
      end

      def error(http_code, text = nil)
        response(text, http_code)
      end

      def perform
        if request.post?
          post
        elsif request.get?
          get
        else
          error(405, "405 Method Not Allowed")
        end
      end

      def headers
        {"Content-Type" => "text/html"}
      end

      def response(content, http_code = 200)
        [http_code, headers, [content]]
      end
    end
  end
end
