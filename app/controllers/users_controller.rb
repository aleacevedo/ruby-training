# frozen_string_literal: true

require 'jwt'

class UsersController < ApplicationController
  def index
    limit = params[:size] || 10
    page = params[:page] || 1
    @users = User.page(page).per(limit)
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  def create
    @user = User.create(create_user_params)
    render json: @user, status: :created
  end

  def update
    User.find(params[:id]).update(update_user_params)
    render status: :ok
  end

  def generate_token
    user = User.find_by email: params[:email]
    return render status: :unauthorized unless user.valid_password? params[:password]

    render json: { token: generate_jwt(user) }, status: :ok
  end

  private

  def create_user_params
    params.require(:user).require(:email)
    params.require(:user).require(:password)
    params.require(:user).require(:first_name)
    params.require(:user).require(:last_name)
    params.require(:user).permit(:email,
                                 :password,
                                 :first_name,
                                 :last_name,
                                 :account_id)
  end

  def update_user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :first_name,
                                 :last_name,
                                 :account_id)
  end

  def generate_jwt(user)
    payload = { data: { user_id: user.id, user_email: user.email } }
    token = JWT.encode payload, nil, 'none'
    token
  end
end
