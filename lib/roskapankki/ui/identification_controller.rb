module Roskapankki
  module UI
    class IdentificationController < Controller
      def self.route
        /roskapankki\/identify/
      end

      def get
        tupas_request = Roskapankki::Tupas::ClientRequest.new

        response(
          Roskapankki::UI::Template.render("Identification", locals: {
            form_values: tupas_request.form_values
          })
        )
      end

      def post
        response(nil)
      end
    end
  end
end
