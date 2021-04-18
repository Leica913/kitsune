class UserCommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = current_user.user_comments.new(user_comment_params)
    comment.article_id = article.id
    comment.save
    redirect_to article_path(article)
  end

  def destroy
    UserComment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    redirect_to article_path(params[:article_id])
  end

  private

  def user_comment_params
     params.require(:user_comment).permit(:comment)
  end
end
