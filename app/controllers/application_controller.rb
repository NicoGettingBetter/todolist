require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  respond_to :json

  def angular
    render 'layouts/application'
  end

private

  def authenticate_user!
    unauthorized! unless current_user
  end
  
  def unauthorized!
    head :unauthorized
  end

  def current_user
    @current_user
  end

  def set_current_user
    token = request.headers['Authorization'].to_s.split(' ').last
    return unless token

    payload = JWT.decode(token, '1a5b356e56c96ad')[0]

    @current_user = User.find_by(id: payload['user_id'])
  end
end
