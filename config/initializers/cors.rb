Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # TODO should specify the origin :)
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
