resources :events, :collection => { :past => :get } do |event|
  event.resources :event_registrations,
    :has_many => :contacts,
    :member => { :pay => :get, :complete => :get }
end

namespace :admin do |admin|
  admin.resources :events, :has_many => :event_prices do |event|
    event.resources :event_registrations,
      :has_many => :contacts,
      :member => { :csv => :get, :paid => :get, :unpaid => :get }
  end
end
