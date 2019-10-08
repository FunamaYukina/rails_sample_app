class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # puts "----------------"
    # puts unencrypted_password=params[:session][:password]
    # puts  BCrypt::Password.new(user.password_digest).is_password?(unencrypted_password)
    # puts "----------------"
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end


end
