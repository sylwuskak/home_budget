class StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_variables, except: [:sum_statistics]
  
  def statistics
    @general_statistics = @statistic_creator&.general_statistics
  end

  def full_statistics_image
    photo_data = @statistic_creator&.full_statistics
    if photo_data.nil?
      return photo_data
    end
    send_data(photo_data, :filename => 'full_statistics.png', :type => 'image/png', :disposition => "inline")
  end

  def statistics_per_month_image
    photo_data = @statistic_creator&.statistics_per_month
    if photo_data.nil?
      return photo_data
    end
    send_data(photo_data, :filename => 'statistics_per_month.png', :type => 'image/png', :disposition => "inline")
  end

  def expense_type_statistics_image
    photo_data = @statistic_creator&.expense_type_statistics
    if photo_data.nil?
      return photo_data
    end
    send_data(photo_data, :filename => 'expense_type_statistics.png', :type => 'image/png', :disposition => "inline")
  end

  def sum_statistics
    if params['date_to'].to_s.empty? 
      if params['date_from'].to_s.empty?
        return nil
      end
      params_date_from = params['date_from'].split('-').map{|a| a.to_i}
      original_date_from = Date.new(*params_date_from) 
      if original_date_from.month != Date.today.month
        return nil
      end

      @date_from = original_date_from.prev_month(3)
      @date_to = Date.new(*params_date_from).next_month.prev_day

      operations = current_user.operations.select{|o| o.date >= @date_from && o.date <= @date_to}
      
      @statistic_creator = Tools::StatisticCreator.new(nil, operations, nil)

      photo_data = @statistic_creator&.sum_statistics
      if photo_data.nil?
        return photo_data
      end
      return send_data(photo_data, :filename => 'sum_statistics.png', :type => 'image/png', :disposition => "inline")
    end
    nil
  end


  private
  def set_variables
    @statistic_creator = nil

    if params['date_from']
      params_date_from = params['date_from'].split('-').map{|a| a.to_i}
      params_date_to = params['date_to'].to_s.empty? ? params_date_from : params['date_to'].split('-').map{|a| a.to_i}

      @date_from = Date.new(*params_date_from)
      @date_to = Date.new(*params_date_to).next_month.prev_day

      if @date_from > @date_to
        flash[:danger] = I18n.t('statistics.date_validations')
      end

      operations = current_user.operations.select{|o| o.date >= @date_from && o.date <= @date_to}
      budgets = current_user.budgets.select{|b| b.date >= @date_from && b.date <= @date_to}

      @statistic_creator = Tools::StatisticCreator.new(current_user.categories, operations, budgets)
    end
  end
end