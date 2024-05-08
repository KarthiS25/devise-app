Rails.application.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      expose: [:Authorization],
      methods: %i[get, post, put, delete, options, show]
  end
end