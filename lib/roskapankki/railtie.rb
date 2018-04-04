module Roskapankki
  class Railtie < Rails::Railtie
    initializer "roskapankki.configure_rails_initialization" do |app|
      app.middleware.use Roskapankki::Middleware
    end
  end
end
