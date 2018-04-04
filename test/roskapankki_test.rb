require "test_helper"
require "rack/test"

class RoskapankkiTest < Minitest::Test
  include Rack::Test::Methods

  def test_that_it_has_a_version_number
    refute_nil ::Roskapankki::VERSION
  end

  def app
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['All responses are OK']] }
    builder = Rack::Builder.new
    builder.run Roskapankki::Middleware.new(app)
  end

  def test_response_is_ok
    get '/'

    assert last_response.ok?
    assert_equal last_response.body, 'All responses are OK'
  end

  def test_responses_to_roskapankki_path
    get '/roskapankki'

    assert last_response.ok?
    assert_empty last_response.body
  end
end
