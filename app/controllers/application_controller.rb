class ApplicationController < ActionController::API
  include Error::ErrorHandler

  private

  def current_user
    User.find(params[:user_id])
  end
end
