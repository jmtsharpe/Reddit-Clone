class CommentsController < ApplicationController

  before_action :requires_logged_in

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    redirect_to post_url(comment_params[:post_id])
  end

  def show
    @comment = Comment.includes(:child_comments).find(params[:id])
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end


end
