# frozen_string_literal: true

class API::Todo < Grape::API
  desc 'API for modifying TODO list'
  namespace :todo do
    desc 'Returns a list of TODO'
    params do
      optional :only_active, type: Boolean, default: false,
        desc: 'Return only active items'
    end
    get do
      method = params[:only_active] ? :active : :all
      Todo.send(method)
    end

    desc 'Creates new TODO'
    params do
      requires :title, type: String, allow_blank: false
    end
    post do
      item = Todo.create!(declared params)
    end

    desc 'Updates existing TODO'
    params do
      requires :id, type: Integer
      optional :title, type: String, allow_blank: false
      optional :done, type: Boolean
      at_least_one_of :title, :done
    end
    put ':id' do
      todo = Todo.find_by params.slice(:id)
      error!('Not found', 404) unless todo

      todo.update!((declared params).except(:id).compact)
      todo
    end

    desc 'Removes existing TODO'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      todo = Todo.find_by params
      error!('Not found', 404) unless todo

      todo.destroy!

      status 204
      ''
    end
  end
end
