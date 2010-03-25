class Article < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_blogs/app/models/article.rb"
  has_and_belongs_to_many :material_categories
  has_and_belongs_to_many :materials
end

