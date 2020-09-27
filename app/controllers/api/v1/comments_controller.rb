class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy, :like]
  before_action :set_post, only: [:post_comments, :create]
  before_action :authorize_request, only: [:create, :like]

  # GET /comments/post/:id
  def post_comments
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/:id
  def show
    render json: { post: @comment, likes: CommentLike.where(comment_id: @comment.id) }
  end

  # POST /comments/new/post/:id
  def create
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment.destroy
  end

  # POST /comments/:id/like
  def like
    @comment_like = CommentLike.find_by(user_id: @user.id, comment_id: @comment.id)
    if @comment_like
      CommentLike.destroy_by(id: @comment_like.id)
    else
      @comment_like = CommentLike.new
      @comment_like.user = @user
      @comment_like.comment = @comment
      if @comment_like.save
        render json: @comment_like, status: :created
      else
        render json: @comment_like.errors, status: :unprocessable_entity
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
