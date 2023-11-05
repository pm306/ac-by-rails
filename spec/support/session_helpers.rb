# spec/support/session_helpers.rb
module SessionHelpers
    def is_logged_in?
      !session[:user_id].nil?
    end
  
    def log_in(user)
      session[:user_id] = user.id
    end
  end
  
  RSpec.configure do |config|
    config.include SessionHelpers, type: :request
  end
  