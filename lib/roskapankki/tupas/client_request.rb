module Roskapankki
  module Tupas
    class ClientRequest
      class MacMismatch < ::RuntimeError ; end
      ALLOWED_PARAMS = %w(A01Y_ACTION_ID A01Y_VERS A01Y_RCVID A01Y_LANGCODE A01Y_STAMP
        A01Y_IDTYPE A01Y_RETLINK A01Y_CANLINK A01Y_REJLINK A01Y_KEYVERS A01Y_ALG A01Y_MAC)

      attr_reader :params

      def initialize(params)
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
