class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.friendly.find(params[:id])
    if params[:id] != @post.slug
      return redirect_to @post, :status => :moved_permanently
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
