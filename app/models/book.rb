class Book < ApplicationRecord
	belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def Book.search(search, user_or_book, how_search)
    if user_or_book == "2"
      if how_search == "1" && search != ""
        if Book.where(['title LIKE ?', "#{search}"]).exists?
          Book.where(['title LIKE ?', "#{search}"])
        else
          Book.all
        end

      elsif how_search =="2" && search != ""
        if Book.where(['title LIKE ?', "%#{search}"]).exists?
          Book.where(['title LIKE ?', "%#{search}"])
        else
          Book.all
        end

      elsif how_search =="3" && search != ""
        if Book.where(['title LIKE ?', "#{search}%"]).exists?
          Book.where(['title LIKE ?', "#{search}%"])
        else
          Book.all
        end

      elsif how_search =="4" && search != ""
        if Book.where(['title LIKE ?', "%#{search}%"]).exists?
          Book.where(['title LIKE ?', "%#{search}%"])
        else
          Book.all
        end

      else
       Book.all
      end
    end
  end

	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
