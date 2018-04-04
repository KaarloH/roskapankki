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
        [200, { 'Content-Type' => 'text/html' }, ['']]
      end
    end
  end
end
