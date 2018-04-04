require 'securerandom'
require 'rack/utils'

module Roskapankki
  module Tupas
    class BankRequest
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def redirect_url
        "#{@params['A01Y_RETLINK']}?#{Rack::Utils.build_query(response_params)}"
      end

      def response_params
        params = {
          "B02K_VERS" => "0003",
          "B02K_TIMESTMP" => "999" + Roskapankki::Tupas::Utils.timestamp,
          "B02K_IDNBR" => SecureRandom.hex(4),
          "B02K_STAMP" => @params["A01Y_STAMP"],
          "B02K_CUSTNAME" => @params["B02K_CUSTNAME"],
          "B02K_KEYVERS" => "0001",
          "B02K_ALG" => "03",
          "B02K_CUSTID" => @params["B02K_CUSTID"],
          "B02K_CUSTTYPE" => "01"
        }

        params.merge({"B02K_MAC" => Roskapankki::Tupas::Utils.compute_mac(params)})
      end
    end
  end
end
