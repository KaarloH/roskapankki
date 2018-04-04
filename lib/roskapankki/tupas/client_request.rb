module Roskapankki
  module Tupas
    class ClientRequest
      class MacMismatch < ::RuntimeError ; end

      attr_reader :params

      def self.mock_params
        params = {
          "A01Y_ACTION_ID" => "701",
          "A01Y_VERS" => "0003",
          "A01Y_RCVID" => "1234567890123",
          "A01Y_LANGCODE" => "FI",
          "A01Y_STAMP" => Roskapankki::Tupas::Utils.timestamp,
          "A01Y_IDTYPE" => "02",
          "A01Y_RETLINK" => "http://localhost:9292?return",
          "A01Y_CANLINK" => "http://localhost:9292?cancel",
          "A01Y_REJLINK" => "http://localhost:9292?reject",
          "A01Y_KEYVERS" => "0001",
          "A01Y_ALG" => "03"
        }

        params.merge({"A01Y_MAC" => Roskapankki::Tupas::Utils.compute_mac(params)})
      end

      def initialize(params = ClientRequest.mock_params)
        @params = params
        @mac_hash = @params.delete("A01Y_MAC")

        validate!
      end

      def validate!
        if Roskapankki::Tupas::Utils.compute_mac(@params) != @mac_hash
          raise MacMismatch
        end
      end

      def form_values
        Hash[["A01Y_RETLINK", "A01Y_CANLINK", "A01Y_REJLINK", "A01Y_STAMP"].map { |param_key| [param_key, @params[param_key]] }]
      end
    end
  end
end
