class HomeController < ApplicationController
  def index
    @welcome_message = if user_signed_in?
      I18n.t('welcome.welcome_messages.signed_in')
    else
      I18n.t('welcome.welcome_messages.signed_out')
    end
  end
end