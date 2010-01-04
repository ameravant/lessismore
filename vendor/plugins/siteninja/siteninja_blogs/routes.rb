resources :article_categories
resources :articles, :member => { :comment => :post }

namespace :admin do |admin|
  admin.resources :article_categories
  admin.resources :articles, :has_many => [ :comments, :images, :features, :assets ], :member => { :reorder => :put }
end

blog '/blog', :controller => 'articles'
