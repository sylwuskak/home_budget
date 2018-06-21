class CalendarController < ApplicationController
  before_action :authenticate_user!

  def show_calendar
    @operations = current_user.operations
  end
end