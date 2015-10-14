class Record < ActiveRecord::Base
  validates :date, presence: true
end
