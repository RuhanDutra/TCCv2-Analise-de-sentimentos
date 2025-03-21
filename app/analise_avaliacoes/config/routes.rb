Rails.application.routes.draw do
  resources :avaliacoes
  resources :produtos
      root to: 'dashboard#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "carrega_avaliacoes/:produto_id", to: "produtos#carrega_avaliacoes", as:"carrega_avaliacoes"
  get "carga_produtos_avaliacoes", to: "dashboard#carga_produtos_avaliacoes", as:"carga_produtos_avaliacoes"
  post 'avaliacoes/avaliacoes_por_csv(/:produto_id)', to: 'avaliacoes#avaliacoes_por_csv', as: 'avaliacoes_por_csv'
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
