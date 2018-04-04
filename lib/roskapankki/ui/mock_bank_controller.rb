module Roskapankki
  module UI
    class MockBankController < Controller
      def self.route
        /roskapankki/
      end

      def get
        tupas_request = Roskapankki::Tupas::ClientRequest.new

        response(
          Roskapankki::UI::Template.render("bank", locals: {
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
