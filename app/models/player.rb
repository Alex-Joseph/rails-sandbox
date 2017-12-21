class Player < ActiveRecord::Base
    validates :first_name, :last_name, :born_on, presence: true
end

