class StatisticsController < ApplicationController
  before_action :authenticate_user!
  
  def statistics
    @statistic_creator = Tools::StatisticCreator.new(current_user.categories, current_user.operations)
  end

  def statistics_image
    # photo_data = statistic_creator.first_test
    @statistic_creator = Tools::StatisticCreator.new(current_user.categories, current_user.operations)
    photo_data = @statistic_creator.full_statistics
    send_data(photo_data, :filename => 'statistics.png', :type => 'image/png', :disposition => "inline")
  end
end