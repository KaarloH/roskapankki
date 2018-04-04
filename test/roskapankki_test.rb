require "test_helper"
require "rack/test"

class RoskapankkiTest < Minitest::Test
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
    get '/roskapankki'

    assert last_response.ok?
    assert_template "bank", last_response.body
  end

  def test_post_returns_success
    post '/roskapankki'

    assert last_response.ok?
    assert_empty last_response.body
  end

  def test_put_returns_error
    put '/roskapankki'

    assert last_response.method_not_allowed?, "should return 405 Method Not Allowed"
    assert_equal "405 Method Not Allowed", last_response.body
  end
end
