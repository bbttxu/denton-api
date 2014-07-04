DentonApi::Application.routes.draw do
  resources :gigs, except: [:new, :edit]
  resources :artists, except: [:new, :edit]
  resources :venues, except: [:new, :edit]

	get '/shows/calendar', to: 'shows#calendar'
	get '/shows/:date', to: 'shows#day'
  resources :shows, except: [:new, :edit]

  # You can have the root of your site routed with "root"
  root 'shows#index'
end
