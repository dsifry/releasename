# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter { |c| Authorization.current_user = c.current_user }

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected

  def permission_denied
  flash[:error] = "Sorry, you are not allowed to access that page."
  redirect_to root_url
  end
end
