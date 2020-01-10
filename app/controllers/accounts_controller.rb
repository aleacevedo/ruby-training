class AccountsController < ApplicationController
    def index
        limit = params[:size] || 10
        offset = params[:page] ? (limit * page) : (limit * 0)
        @accounts = Account.limit(limit).offset(offset)
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
