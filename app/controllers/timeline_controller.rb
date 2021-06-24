class TimelineController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @booker = Book.where("created_at >= ?", Date.today).limit(20)
  end
  
end
