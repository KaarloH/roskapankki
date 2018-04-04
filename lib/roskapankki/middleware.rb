require 'rack'

module Roskapankki
  class Middleware
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      if request.path_info =~ Roskapankki::UI::MockBankController.route
        Roskapankki::UI::MockBankController.new(request).perform
      else
        @app.call(env)
      end
    end
  end
end
