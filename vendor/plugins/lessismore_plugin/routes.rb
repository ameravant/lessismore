map.resources :material_categories, :materials, :locations, :regions
map.namespace :admin do |admin|
  admin.resources :locations, :material_categories, :materials, :regions
end