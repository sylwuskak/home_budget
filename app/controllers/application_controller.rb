class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = (['en', 'pl'].include?(params[:locale]) ? params[:locale] : nil ) || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
