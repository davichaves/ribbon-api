class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, only: [:profile, :update]
  before_action :set_user, only: [:destroy]

  # POST /users/auth/signup
  def signup
    begin
      @user = User.new(signup_params)
      if @user.save
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       user: @user }, status: :created
      else
        render json: { error: @user.errors.full_messages }, status: :bad_request unless !@user.errors.full_messages.any?
      end
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: "email already taken" }, status: :unauthorized
    end
  end

  # POST /users/auth/signin
  def signin
    @user = User.find_by(signin_params)
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user: @user }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/profile
  def profile
    render json: @user
  end

  # PATCH/PUT /users
  def update
    if @user.update(signup_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.

    def signup_params
      params.permit(:email, :password, :name)
    end

    def signin_params
      params.permit(:email)
    end

    def update_params
      params.permit(:email)
    end
end
