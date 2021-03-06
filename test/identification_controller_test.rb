require "test_helper"
require "rack/test"

class IdentificationControllerTest < Minitest::Test
  include Rack::Test::Methods

  def test_that_it_has_a_version_number
    refute_nil ::Roskapankki::VERSION
  end

  def test_response_is_ok
    get '/'

    assert last_response.ok?
    assert_equal 'All responses are OK', last_response.body
  end

  def test_get_renders_bank_template
    get '/roskapankki/identify', mock_identify_params

    assert last_response.ok?
    refute_empty last_response.body
  end

  def test_post_renders_bank_template
    post '/roskapankki/identify', mock_identify_params

    assert last_response.ok?
    refute_empty last_response.body
  end

  def test_put_returns_error
    put '/roskapankki/identify'

    assert last_response.method_not_allowed?, "should return 405 Method Not Allowed"
    assert_equal "405 Method Not Allowed", last_response.body
  end
end
