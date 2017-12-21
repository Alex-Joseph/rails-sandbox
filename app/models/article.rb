class Article < ActiveRecord::Base
    has_many :comments
    accepts_nested_attributes_for :comments
    validates :title, presence: true, 
                      length: { minimum: 5 } 
end
