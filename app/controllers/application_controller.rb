class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # Si el usuario no esta referenciado, lo busca y lo memoriza
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Muestra si estamos loggeados. '!!' = Boolean
  def logged_in?
    !!current_user
  end

  # No permite ejecutar acciones si no estamos loggeados
  def require_user
    unless logged_in?
      flash[:alert] = 'You need to be logged in to perform that action'
      redirect_to login_path
    end
  end
end
