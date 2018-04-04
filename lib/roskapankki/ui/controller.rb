require "roskapankki/ui/template"
require "roskapankki/tupas"

module Roskapankki
  module UI
    class Controller
      attr_reader :request

      def initialize(request)
        @request = request
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
        wrapped_content =
          if content.nil?
            []
          else
            [content]
          end

        [http_code, headers, wrapped_content]
      end
    end
  end
end
