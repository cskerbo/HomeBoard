class Widget < ApplicationRecord
  belongs_to :home
  has_many :users, through: :home
end
