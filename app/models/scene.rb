#
class Scene < ApplicationRecord
  belongs_to :group
  belongs_to :bridge
end

