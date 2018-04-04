require "test_helper"
require "rack/test"

class VerificationControllerTest < Minitest::Test
  include Rack::Test::Methods

  def test_post_redirects
    post '/roskapankki/verify'

    assert last_response.redirect?
    #assert_equal "http://test.com/", last_response.location
  end

  def test_get_returns_error
    get '/roskapankki/verify'

    assert last_response.method_not_allowed?, "should return 405 Method Not Allowed"
  end

  def test_put_returns_error
    put '/roskapankki/verify'

    assert last_response.method_not_allowed?, "should return 405 Method Not Allowed"
  end
end
