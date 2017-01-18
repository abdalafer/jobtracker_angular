class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :add_initial_breadcrumbs

  def non_auth_current_user
    @current_user = User.first
  end

  def api_response(json_body = nil, status_code = 200)
    return render json: json_body, status: status_code
  end
  private
  def add_initial_breadcrumbs
   # breadcrumbs.add "Home", root_path
  end
end
