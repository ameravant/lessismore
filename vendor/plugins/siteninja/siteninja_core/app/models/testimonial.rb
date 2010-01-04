class Testimonial < ActiveRecord::Base
  belongs_to :quotable, :polymorphic => true, :counter_cache => true
end
