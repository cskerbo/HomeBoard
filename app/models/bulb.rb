class Bulb < ApplicationRecord
  belongs_to :bridge
  belongs_to :group
end