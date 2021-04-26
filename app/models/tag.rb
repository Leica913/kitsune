class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :articles, through: :tag_maps
end
