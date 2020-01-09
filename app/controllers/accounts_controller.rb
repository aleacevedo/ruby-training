class AccountsController < ApplicationController
    def index
        limit = params[:size] || 10
        offset = params[:page] ? (limit * page) : (limit * 0)
        @accounts = Account.limit(limit).offset(offset)
        render json: @accounts, status: 200
    end

    def show
        @account = Account.find(params[:id])
        render json: @account, status: 200
    end

    def create
        @account = Account.create(params[:account])
        render status: 201
    end

    def update
        Account.find(params[:id]).update_attributes(params[:account])
        render status: 200
    end

    def destroy
        @patient = Patient.find(params[:id])
        @patient.destroy
        render status: 200
    end
end
