module Roskapankki
  module UI
    class IdentificationController < Controller
      def self.route
        /roskapankki\/identify/
      end

      def get
        process
      end

      def post
        process
      end

      def process
        tupas_request = Roskapankki::Tupas::ClientRequest.new(filtered_parameters)

        response(
          Roskapankki::UI::Template.render("identification", locals: {
            form_values: tupas_request.form_values
          })
        )
      end

      def filtered_parameters
        @filtered_parameters ||= params.select { |k, v| Roskapankki::Tupas::ClientRequest::ALLOWED_PARAMS.include?(k) }
      end
    end
  end
end
