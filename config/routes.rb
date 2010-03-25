ActionController::Routing::Routes.draw do |map|  
  map.resource :session
  # map.search '/search', :controller => "search", :action => "search"
  map.resources :searches
  map.root :controller => "pages", :action => "index"
  map.from_plugin :siteninja_core
  map.from_plugin :lessismore_plugin
  map.from_plugin :siteninja_blogs
  map.from_plugin :siteninja_events
  map.from_plugin :siteninja_pages # Must be last!
end
