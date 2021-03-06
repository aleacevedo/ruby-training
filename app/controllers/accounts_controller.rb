# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]
  def index
    limit = params[:limit] || 10
    page = params[:page] || 1
    @accounts = Account.page(page).per(limit)
    render json: @accounts, status: :ok
  end

  def show
    @account = Account.find(params[:id])
    render json: @account, status: :ok
  end

  def create
    @account = Account.create(create_account_params)
    render json: @account, status: :created
  end

  def update
    Account.find(params[:id]).update(update_account_params)
    render status: :ok
  end

  private

  def create_account_params
    params.require(:account).permit(:name)
  end

  def update_account_params
    params.require(:account).permit(:name)
  end
end
