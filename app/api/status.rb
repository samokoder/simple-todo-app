# frozen_string_literal: true

class API::Status < Grape::API
  get :status do
    { status: :ok }
  end
end
