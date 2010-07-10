map.resources :material_categories, :materials, :locations, :regions

map.namespace :admin do |admin|
  admin.resources :locations, :material_categories, :materials, :regions, :redirects
end

contact_us "/contact-us", :controller => 'inquiries', :action => "new"
resources :settings, :as => :stylesheet, :collection => { :additional_styles => :get }
resources :settings, :as => :javascript, :collection => { :javascript => :get }
# additional_styles "/additional_styles", :controller => 'settings', :action => "additional_styles"
# javascript "/javascript", :controller => 'settings', :action => "javascript"