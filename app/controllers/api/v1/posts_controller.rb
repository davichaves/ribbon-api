class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :authorize_request, only: [:create, :update]

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
