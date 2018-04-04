require 'roskapankki'

app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['All responses are OK']] }

run Roskapankki::Middleware.new(app)
