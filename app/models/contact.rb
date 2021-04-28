class Contact < ApplicationRecord
  belongs_to :user
    #バリデーション
    validates :name, presence: true
    validates :email, presence: true
    validates :content, presence: true
end
