class Spreadsheet < ApplicationRecord
  has_many :tags
  validates_presence_of :name
end
