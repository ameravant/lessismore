ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resources :materials
  
  map.resource :session
  map.resources :material_categories, :materials, :locations, :regions
  # map.search '/search', :controller => "search", :action => "search"
  map.resources :searches
  
  map.namespace :admin do |admin|
    admin.resources :locations, :material_categories, :materials, :regions
  end
  map.root :controller => "pages", :action => "index"
  map.from_plugin :siteninja_core
  map.from_plugin :siteninja_blogs
  map.from_plugin :siteninja_events
  map.from_plugin :siteninja_pages # Must be last! 
end
