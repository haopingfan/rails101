# used by devise(routes.rb):
# devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
# override OmniauthCallbacksController in Devise

class CallbacksController < Devise::OmniauthCallbacksController
  before_action :callback_handler

  def facebook; end

  def google_oauth2; end

  private

  def callback_handler
    auth = request.env['omniauth.auth']
    @identity = Identity.find_or_intialize_with_omniauth(auth)

    if @identity.user
      sign_in @identity.user
      redirect_to root_path, notice: 'Signed in. Welcome back!'
    elsif User.find_by(email: auth.info['email'])
      @user = User.find_by(email: auth.info['email'])
      set_identity_and_sign_in(@identity, @user, 'Successfully linked this account. Signed in. Welcome back!')
    else
      @user = User.initialize_with_omniauth(auth)
      @user.save # @user needs to hit database first to get id and sign in
      set_identity_and_sign_in(@identity, @user, 'Registered. Welcome to Bonbonwo101!')
    end
  end

  def set_identity_and_sign_in(identity, user, msg)
    identity.user_id = user.id
    identity.save
    sign_in user
    redirect_to root_path, notice: msg
  end
end
