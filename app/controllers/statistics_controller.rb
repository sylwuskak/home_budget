class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_variables
  
  def statistics
    @general_statistics = @statistic_creator&.general_statistics

  end

  def full_statistics_image
    photo_data = @statistic_creator&.full_statistics
    send_data(photo_data, :filename => 'full_statistics.png', :type => 'image/png', :disposition => "inline")
  end

  def statistics_per_month_image
    photo_data = @statistic_creator&.statistics_per_month
    send_data(photo_data, :filename => 'statistics_per_month.png', :type => 'image/png', :disposition => "inline")
  end


  private
  def set_variables
    @statistic_creator = nil

    if params['date_from'] && params['date_to']
      params_date_from = params['date_from'].split('-').map{|a| a.to_i}
      params_date_to = params['date_to'].split('-').map{|a| a.to_i}

      @date_from = Date.new(*params_date_from)
      @date_to = Date.new(*params_date_to).next_month.prev_day

      operations = current_user.operations.select{|o| o.date >= @date_from && o.date <= @date_to}
      budgets = current_user.budgets.select{|b| b.date >= @date_from && b.date <= @date_to}

      @statistic_creator = Tools::StatisticCreator.new(current_user.categories, operations, budgets)
    end
  end
end