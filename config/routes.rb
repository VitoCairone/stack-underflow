StackUnderflow::Application.routes.draw do
  resources :tags

  root to: "questions#index"

  resources :questions do
    resources :answers, only: [:create, :destroy, :new]
    resources :comments, only: [:create, :destroy, :new]
    resources :votes, only: [:create, :destroy]
  end
  resources :users, only: [:create, :destroy, :new]
  resource :session, only: [:create, :destroy, :new]
  #/answers/ exists exclusively to nest comments underneath, so that
  # comments can be posted both on questions and on answers. The actual answers
  # routes are those nested under questions.
  resources :answers, only: [] do
    resources :comments, only: [:create, :destroy, :new]
    resources :votes, only: [:create, :destroy]
  end

  #TODO: investigate ActiveRecord Reputation?
end
