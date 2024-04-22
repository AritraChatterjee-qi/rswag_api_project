class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      puts 'error'
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  # PATCH /users/{id}/change_status
  def change_status
    binding.pry
    user_id = params["user_id"]

    user = User.find_by_id(user_id)

    unless user
      render json: { error: "User not found. Incorrect user id." }, status: :not_found
      return
    end

    unless params["status"]
      render json: { error: "status value is not provided" }, status: :unprocessable_entity
      return
    end

    User.update!(status: (params["status"] == "true"))

    render json: { msg: "status updated sucessfully", user: user.reload }, status: 202
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :car_id, :bike_id)
    end
end
