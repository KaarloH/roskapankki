require "test_helper"
require "roskapankki/tupas"

class TupasClientRequestTest < Minitest::Test

  def valid_client_request
    @client_request ||= Roskapankki::Tupas::ClientRequest.new(mock_params)
  end

  def test_valid_client_request
    assert valid_client_request
  end

  def test_raise_when_hashes_dont_match
    assert_raises(Roskapankki::Tupas::ClientRequest::MacMismatch) do
      Roskapankki::Tupas::ClientRequest.new(mock_params({"A01Y_MAC" => "foobar"}))
    end
  end

  def test_form_values_returns_correct_fields
    expected_hash = {
      "A01Y_RETLINK" => "http://localhost:9292?return",
      "A01Y_CANLINK" => "http://localhost:9292?cancel",
      "A01Y_REJLINK" => "http://localhost:9292?reject",
      "A01Y_STAMP" => valid_client_request.params["A01Y_STAMP"]
    }

    assert_equal expected_hash, valid_client_request.form_values
  end

  def mock_params(params = {})
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
