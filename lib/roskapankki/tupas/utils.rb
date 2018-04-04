require 'digest'

module Roskapankki
  module Tupas
    class Utils
      def self.timestamp
        Time.now.strftime("%Y%m%d%H%M%S%6N")
      end

      def self.secret_key
        "snakeoil"
      end

      def self.compute_mac(params)
        message = params.values.join('&')
        payload = (message+'&'+secret_key+'&').encode(Roskapankki::Tupas::ENCODING)
        Digest::SHA256.hexdigest(payload).upcase
      end
    end
  end
end
