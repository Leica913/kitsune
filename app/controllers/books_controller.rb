class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_book, only: [:edit, :update]

  def show
    @book = Book.new
  	@post_book = Book.find(params[:id])
    @book_comment = BookComment.new
    @task = Book.includes(:user,:tags).all.order('created_at DESC') #タグ付け
    if params[:tag_name]
      @tasks = Book.tagged_with("#{params[:tag_name]}")
    end
    #@book_comments = @post_book.book_comments.order(created_at: :desc)
  end

  def new
    @book = Book.new
  end

  def index
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.includes(:user,:tags).all.order('created_at DESC') #タグ付け
    if params[:tag_name]
      @books = Book.tagged_with("#{params[:tag_name]}")
    end
  end


  def create
    @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
      redirect_to book_path(@book.id), notice: "投稿が完了しました。"#保存された場合の移動先を指定。
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end


  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "successfully updated book!"
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
  end



  private

  def book_params
    #tag_listをpermitに追加
    params.require(:book).permit(:title, :body, :tag_list).merge(user_id: current_user.id)
  end

  def baria_book
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def set_book
    @book = Book.find(params[:id])
  end

end


