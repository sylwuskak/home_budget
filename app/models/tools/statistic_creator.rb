class Tools::StatisticCreator
  
  def initialize(categories, operations, budgets)
    require 'gruff'

    @categories = categories
    @operations = operations
    @budgets = budgets

    @my_theme = {
      :colors => [
        '#1357cc', # blue
        '#3a7e0f', # green
        '#df3314', # red
        '#dadada', # grey
        '#ce00db', # purple
        '#0d9bb0', # light blue
        '#ece200', # yellow
        '#54260c', # dark brown 
        '#7f08a9', # violet
        '#ff6600', # orange
        '#6fff00', # light green
        '#ff66e1', # pink
        '#00ecff', # light blue
        '#ffaa00', # orange 2
        '#494f4f', # dark grey
        '#030585', # dark blue
        '#a94c19', # brown
        '#000000', # black
        '#ff008d', # raspberry
        '#515a09', # dark green 
      ],
      :marker_color => '#aea9a9', # Grey
      :font_color => 'black',
      :background_colors => 'white'
    }
  end

def general_statistics
    expenses_sum = @operations.select{|o| o.is_a? Expense}.map{|o| o.amount}.sum.round(2)
    incomings_sum = @operations.select{|o| o.is_a? Incoming}.map{|o| o.amount}.sum.round(2)
    grouped_budgets = @budgets.group_by{|o| o.category_id}
    expenses_operations = @operations.select{|o| o.is_a? Expense}.group_by{|o| o.category_id}

    grouped_expenses_operations = @categories.map do |category|
      operations = expenses_operations[category.id].to_a
      {category_id: category.id, category: category.category_name, sum: operations.map{|o| o.amount}.sum.round(2), operations: operations.sort_by{|o| o.date}.reverse, budget_amount: grouped_budgets[category.id].to_a.map{|b| b.amount.to_f}.sum.round(2)}
    end.sort_by{|h| -h[:sum]}

    grouped_incomings_operations = @operations.select{|o| o.is_a? Incoming}.group_by{|o| o.category_id}.map do |category_id, operations|
      {category_id: category_id, category: @categories.find(category_id).category_name, sum: operations.map{|o| o.amount}.sum.round(2), operations: operations.sort_by{|o| o.date}.reverse}
    end.sort_by{|h| -h[:sum]}

    {expenses_sum: expenses_sum, incomings_sum: incomings_sum, grouped_expenses_operations: grouped_expenses_operations, grouped_incomings_operations: grouped_incomings_operations}
  end

  def full_statistics
    photo_data = ''
    
    Dir.mktmpdir do |dir|
      grouped_operations = @operations.select{|o| o.is_a? Expense}.group_by{|o| o.category_id}

      if grouped_operations.empty?
        return nil
      end
      
      datasets = grouped_operations.map do |category_id, operations|
        [@categories.find(category_id).category_name, [operations.map{|o| o.amount}.sum]]
      end.sort_by{|o| -o[1][0]}

      g = Gruff::Pie.new
    
      g.theme = @my_theme
      g.title = I18n.t('operations.expenses')
      datasets.each do |data|
        g.data(data[0], data[1])
      end

      filename = "test-#{SecureRandom.hex(8)}.png"
      filepath = Rails.root.join(dir, filename)
      g.write(filepath)
      photo_data = File.read(filepath)
    end

    photo_data
  end

  def statistics_per_month
    photo_data = ''

    Dir.mktmpdir do |dir|
      grouped_operations = @operations.select{|o| o.is_a? Expense}.group_by{|o| o.category_id}

      if grouped_operations.empty?
        return nil
      end

      all_months = @operations.select{|o| o.is_a? Expense}.map{|o| o.date.year.to_s + "-" + o.date.month.to_s.rjust(2, '0')}.uniq.sort
      
      grouped_operations_per_month = grouped_operations.map do |category_id, operations|
        operations_per_month = operations.group_by{|o| {month: o.date.month, year: o.date.year}}.map{|key, operations| {key[:year].to_s + "-" + key[:month].to_s.rjust(2,'0') => operations.map{|o| o.amount}.sum.round(2)} }
        [@categories.find(category_id).category_name, operations_per_month.reduce({}, :merge) ]
      end.to_h

      @datasets = grouped_operations_per_month.map do |category, operations_hash|
        [category, all_months.map{|month| operations_hash[month].to_f} ] 
      end

      g = Gruff::SideStackedBar.new
      g.title = I18n.t('operations.expenses_per_month')
      g.theme = @my_theme

      g.labels = all_months.each_with_index.map{|m, i| [i, m]}.to_h
      @datasets.each do |data|
        g.data(data[0], data[1])
      end


      filename = "test-#{SecureRandom.hex(8)}.png"
      filepath = Rails.root.join(dir, filename)
      g.write(filepath)
      photo_data = File.read(filepath)
    end
    
    photo_data
  end
end