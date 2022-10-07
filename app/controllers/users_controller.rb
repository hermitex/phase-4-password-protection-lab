class UsersController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    new_user = User.create!(new_user_params)
    session[:user_id] = new_user[:id]
    render json: new_user, status: :created
  end

  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: user, status: :ok
    else
      render json: {error: "Password or username invalid"}, status: :unauthorized
    end
  end

  private
  def new_user_params
    params.permit(:username, :password, :password_confirmation)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

end
