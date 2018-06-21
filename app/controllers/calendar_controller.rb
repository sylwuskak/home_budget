class CalendarController < ApplicationController
  before_action :authenticate_user!

  def show_calendar
    @operations = Operation.all
  end
end