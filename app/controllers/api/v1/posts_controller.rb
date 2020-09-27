class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy, :like]
  before_action :authorize_request, only: [:create, :update, :like]

  # GET /posts
  def all_posts
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts/new
  def create
    @post = Post.new(post_params)
    @post.user = @user

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  # POST /posts/:id/like
  def like
    @post_like = PostLike.where(user_id: @user.id, post_id: @post.id)
    if @post_like
      @post_like.destroy
    else
      @post_like = PostLike.new
      @post_like.user = @user
      @post_like.post = @post
      if @post_like.save
        render json: @post_like, status: :created
      else
        render json: @post_like.errors, status: :unprocessable_entity
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:description, :post_type, :media_url)
    end
end
