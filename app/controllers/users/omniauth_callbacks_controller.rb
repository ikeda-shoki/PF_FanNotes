# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  def twitter
    callback_from(:twitter)
  end

  def google_oauth2
    callback_from(:google_oauth2)
  end

  def failure
    redirect_to root_path
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_or_create_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      if provider === @user.provider
        if provider === "twitter"
          sns_name = "twitter"
        else
          sns_name = "Google"
        end
        flash[:notice] = "#{sns_name}認証でのログインに成功しました"
        sign_in_and_redirect @user
      else
        redirect_to new_user_registration_url, alert: "違うアカウントでのログイン実績が存在します"
      end
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
