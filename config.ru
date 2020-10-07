# frozen_string_literal: true

use Rack::Static,
  urls: [''], root: 'public/dist', index: 'index.html'

run proc {
  [
    200,
    { 'Content-Type' => 'text/html' },
    File.open('public/dist/index.html', File::RDONLY)
  ]
}
