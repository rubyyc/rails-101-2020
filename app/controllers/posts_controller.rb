class PostsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "更新成功!"
      redirect_to account_posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "删除成功!"
    redirect_to account_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
