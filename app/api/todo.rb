# frozen_string_literal: true

class API::Todo < Grape::API
  desc 'API for modifying TODO list'
  namespace :todo do
    desc 'Returns a list of TODO'
    get do
      []
    end

    desc 'Creates new TODO'
    params do
      requires :title, type: String, allow_blank: false
    end
    post do
      {}
    end

    desc 'Updates existing TODO'
    params do
      requires :id, type: Integer
      optional :title, type: String, allow_blank: false
      optional :done, type: Boolean
      at_least_one_of :title, :done
    end
    put ':id' do
      {}
    end

    desc 'Removes existing TODO'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      status 204
      ''
    end
  end
end
