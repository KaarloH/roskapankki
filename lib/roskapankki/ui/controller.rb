require "roskapankki/ui/template"
require "roskapankki/tupas"

module Roskapankki
  module UI
    class Controller
      attr_reader :request

      def self.controllers
        [IdentificationController, VerificationController]
      end

      def self.select_controller(path)
        controllers.find { |controller| path =~ controller.route }
      end

      def initialize(request)
        @request = request
      end

      def error(http_code, text = nil)
        response(text, http_code)
      end

      def perform
        if request.post? && respond_to?(:post)
          post
        elsif request.get? && respond_to?(:get)
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

      def redirect(location)
        [302, {"Location" => location, "Content-Type" => "text/html"}, []]
      end

      def params
        @request.params
      end
    end
  end
end
