class Index < ActiveRecord::Base
  # validates :body, :presence => true
  # validates :title, :presence => true
  belongs_to :post 
  belongs_to :tag
end