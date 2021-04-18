class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit]

  def show
    @article = Article.find(params[:id])
    @article_new = Article.new
    @user_comment = UserComment.new
    @user = @article.user
  end

  def index
    @articles = Article.all
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article), notice: "You have created book successfully."
    else
      @articles = Article.all
      render 'index'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end



  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def ensure_correct_user
    @article = Article.find(params[:id])
      unless @article.user == current_user
      redirect_to articles_path
      end
  end
end
