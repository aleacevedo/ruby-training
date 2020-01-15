# frozen_string_literal: true

require 'jwt'

class ApplicationController < ActionController::API
  protected

  def authentication_data
    @authentication_data ||= JWT.decode(request.headers['x-authorization'], nil, false)
  rescue StandardError => _e
    @authentication_data ||= {}
  end

  def authenticate_user!
    raise UnauthenticatedError if current_user.blank?
  end

  def current_user
    return @current_user if @current_user.present?
    return if request.headers['x-authorization'].blank?

    user_data = authentication_data['user']
    return if user_data.blank?

    @current_user = User.find_by(email: user_data['email'])
    @current_user
  end
end
