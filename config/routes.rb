Rails.application.routes.draw do
  get 'top/main'
  post 'top/login'
  get 'top/logout'
  root 'top#main'
end
