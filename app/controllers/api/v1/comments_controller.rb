class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_post, only: [:post_comments, :create]
  before_action :authorize_request, only: [:create]

  # GET /comments/post/:id
  def post_comments
    @comments = Comment.all

    render json: @comments
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

  # PATCH/PUT /comments/1
  # def update
  #   if @comment.update(comment_params)
  #     render json: @comment
  #   else
  #     render json: @comment.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /comments/1
  def destroy
    @comment.destroy
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
