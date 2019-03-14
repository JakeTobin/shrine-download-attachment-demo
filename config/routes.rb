Rails.application.routes.draw do
  root to: 'albums#index'

  resources :albums

  mount Shrine.presign_endpoint(:cache) => "/s3/params"
  # mount Shrine.upload_endpoint(:cache) => "/upload"
  mount Shrine.download_endpoint => "/attachments"

end
