# spec/support/helpers/session_helpers.rb

module SessionHelpers
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: 'password' } }
    # Set cookies directly in the request
    cookies[:user_id] = user.id
    cookies[:remember_token] = user.remember_token
  end

  def log_in_as_integration(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
