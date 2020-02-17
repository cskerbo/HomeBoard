class Home < ApplicationRecord
  has_many :users
  validates_format_of :zip_code,
                      with: /\A\d{5}-\d{4}|\A\d{5}\z/,
                      message: "should be 12345 or 12345-1234",
                      allow_blank: false
  validates_uniqueness_of :name
  validates_presence_of :name, :state, :street, :city
  geocoded_by :address
  after_validation :geocode

end
