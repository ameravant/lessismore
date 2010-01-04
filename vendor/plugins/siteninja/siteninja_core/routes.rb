resources :inquiries, :only => [ :new, :create ]
resources :testimonials, :assets

namespace :admin do |admin|
  admin.resource :setting
  admin.resources :assets
  admin.resources :users, :member => { :change_password => :get, :change_password_save => :put }
  admin.resources :contacts
  admin.resources :contact_groups
  admin.resources :inquiries
  admin.resources :features, :collection => { :reorder => :put }
end

admin '/admin', :controller => "admin"
inquire '/inquire', :controller => "inquiries", :action => "new"
