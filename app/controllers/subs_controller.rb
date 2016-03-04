class SubsController < ApplicationController

  before_action :requires_logged_in
  before_action :confirm_owner, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.includes(posts: :author).find(params[:id])
    render :show
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def confirm_owner
    @sub = Sub.find(params[:id])
    unless current_user && @sub.moderator_id == current_user.id
      render text: "Only #{@sub.moderator.username} can edit this sub.", status: :forbidden
    end
  end

end
