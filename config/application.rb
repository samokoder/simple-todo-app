# frozen_string_literal: true

require_relative 'environment'

module API; end

Dir[File.expand_path('../app/api/*.rb', __dir__)].each { |f| require f }

class API::Root < Grape::API
  format :json

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  mount API::Status
  mount API::Todo
end

Application = Rack::Builder.new do
  map '/api' do
    run API::Root
  end

  map '/' do
    use Rack::Static,
      urls: [''], root: 'public/dist', index: 'index.html'

    run proc {
      [
        200,
        { 'Content-Type' => 'text/html' },
        File.open('public/dist/index.html', File::RDONLY)
      ]
    }
  end
end
