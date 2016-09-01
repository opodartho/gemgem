class Thing < ActiveRecord::Base
  scope :latest, -> { order(created_at: :desc).limit(9) }
end
