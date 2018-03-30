class Tab < ApplicationRecord
  belongs_to :spreadsheet
  has_many :tags
end
