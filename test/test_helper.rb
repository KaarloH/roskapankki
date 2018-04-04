$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "roskapankki"
require "roskapankki/ui/template"

require "minitest/autorun"

class Minitest::Test
  def app
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['All responses are OK']] }
    builder = Rack::Builder.new
    builder.run Roskapankki::Middleware.new(app)
  end

  def mock_identify_params(params = {})
    default_params = {
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

    default_params.merge({"A01Y_MAC" => Roskapankki::Tupas::Utils.compute_mac(default_params)}).merge(params)
  end
end
