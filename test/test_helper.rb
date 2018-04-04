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
end
