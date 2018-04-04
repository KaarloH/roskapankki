module Roskapankki
  module UI
    class VerificationController < Controller
      def self.route
        /roskapankki\/verify/
      end

      def post
        bank_request = Roskapankki::Tupas::BankRequest.new(params)
        redirect(bank_request.redirect_url)
      end
    end
  end
end
