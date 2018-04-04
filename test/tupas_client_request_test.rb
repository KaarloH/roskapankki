require "test_helper"
require "roskapankki/tupas"

class TupasClientRequestTest < Minitest::Test

  def valid_client_request
    @client_request ||= Roskapankki::Tupas::ClientRequest.new(mock_identify_params)
  end

  def test_valid_client_request
    assert valid_client_request
  end

  def test_raise_when_hashes_dont_match
    assert_raises(Roskapankki::Tupas::ClientRequest::MacMismatch) do
      Roskapankki::Tupas::ClientRequest.new(mock_identify_params({"A01Y_MAC" => "foobar"}))
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
end
