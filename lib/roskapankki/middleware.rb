require 'rack'

module Roskapankki
  class Middleware
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      if controller = Roskapankki::UI::Controller.select_controller(request.path_info)
        controller.new(request).perform
      else
        @app.call(env)
      end
    end
  end
end
