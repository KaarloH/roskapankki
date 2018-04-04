require "test_helper"
require "roskapankki/tupas"

class TupasBankRequestTest < Minitest::Test

  def valid_bank_request
    @bank_request ||= Roskapankki::Tupas::BankRequest.new(mock_params)
  end

  def test_valid_bank_request
    assert valid_bank_request
  end

  def test_redirect_url_returns_url
    assert valid_bank_request.redirect_url
  end

  def mock_params(params = {})
    default_params = {
      "B02K_CUSTID" => "210281-9988",
      "B02K_CUSTNAME" => "MEIKALAINEN MATTI",
      "A01Y_RETLINK" => "http://localhost:9292?return",
      "A01Y_CANLINK" => "http://localhost:9292?cancel",
      "A01Y_REJLINK" => "http://localhost:9292?reject",
      "A01Y_STAMP" => Roskapankki::Tupas::Utils.timestamp
    }.merge(params)
  end
end
