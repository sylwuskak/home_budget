class HomeController < ApplicationController
  def index
    @welcome_message = if user_signed_in?
      I18n.t('welcome.welcome_messages.signed_in')
    else
      I18n.t('welcome.welcome_messages.signed_out')
    end

    cookies[:glupie_ciasteczko] = {
      :value => "Jakieś głupie ciasteczko",
      :expires => Time.now + 6.months,
      # :domain => ['.localhost.com'] #zapisuje na subdomain
      # :domain => %w(.localhost) #nigdzie nie zapisuje
      # :domain => '.localhost.com' #nigdzie nie zapisuje
      :domain => 'herokuapp.com' #nigdzie nie zapisuje
      # :domain => :all #zapisuje na subdomain
    }
  end

  def demo_version
    sign_in(User.where(email: 'demo@example.com').first, scope: :user)
    redirect_to root_path
  end
end