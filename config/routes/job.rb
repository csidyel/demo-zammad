# Copyright (C) 2012-2025 Zammad Foundation, https://zammad-foundation.org/

Zammad::Application.routes.draw do
  api_path = Rails.configuration.api_path

  # jobs
  match api_path + '/jobs',            to: 'jobs#index',   via: :get
  match api_path + '/jobs/search',     to: 'jobs#search',  via: %i[get post]
  match api_path + '/jobs/:id',        to: 'jobs#show',    via: :get
  match api_path + '/jobs',            to: 'jobs#create',  via: :post
  match api_path + '/jobs/:id',        to: 'jobs#update',  via: :put
  match api_path + '/jobs/:id',        to: 'jobs#destroy', via: :delete

end
