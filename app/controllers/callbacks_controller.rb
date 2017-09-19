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
    @identity = Identity.find_by(uid: auth['uid'], provider: auth['provider'])

    if @identity.nil?
      user = User.find_by(email: auth.info['email']) || User.create_with_omniauth(auth)
      @identity = Identity.create(uid: auth['uid'], provider: auth['provider'], user: user)
      # @user needs to hit database first to get id for user_id column and sign in
    end

    sign_in_and_redirect @identity.user
  end
end
