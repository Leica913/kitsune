class ArticlesGenresController < ApplicationController
  #ログインユーザーのみproduct#indexは閲覧可
  before_action :authenticate!, except: [:index, :show]
  #退会済みユーザー
  before_action :member_is_deleted, except: [:index, :show]

  def show
    @articles=Article.all
    @articles_genre = ArticlesGenre.find(params[:id])
  end


  def index
    @articles=Article.all
    @article_genre = ArticlesGenre.all
  end


  private
    def article_genre_params
      params.require(:article_genre).permit(:name)
    end

    #退会済みユーザーへの対応
    def member_is_deleted
      if member_signed_in? && current_member.is_deleted?
         redirect_to root_path
      end
    end
end
