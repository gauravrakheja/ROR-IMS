class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  protect_from_forgery with: :reset_session, unless: :user_logging_in?

  private

  def user_logging_in?
    params[:controller] == "devise/sessions"
  end
end
