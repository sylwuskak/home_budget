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
        '#ce00db' # purple
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
    end.sort_by{|h| h[:category]}

    grouped_incomings_operations = @operations.select{|o| o.is_a? Incoming}.group_by{|o| o.category_id}.map do |category_id, operations|
      {category_id: category_id, category: @categories.find(category_id).category_name, sum: operations.map{|o| o.amount}.sum.round(2), operations: operations.sort_by{|o| o.date}.reverse}
    end.sort_by{|h| h[:category]}

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

  def expense_type_statistics
    photo_data = ''
    
    Dir.mktmpdir do |dir|
      grouped_operations = @operations.select{|o| o.is_a? Expense}.group_by{|o| o.expense_type}

      if grouped_operations.empty?
        return nil
      end
      
      datasets = grouped_operations.map do |expense_type, operations|
        [I18n.t("operations.expense_type.#{expense_type&.downcase}"), [operations.map{|o| o.amount}.sum]]
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

  def sum_statistics
    photo_data = ''

    Dir.mktmpdir do |dir|
      g = Gruff::Bar.new(800)
      g.title = I18n.t('operations.expenses_to_day', :day => Date.today.day)
      g.theme = @my_theme
      
      grouped_operations_for_view = Array.new(4, 0)

      grouped_operations = @operations.select{|o| o.is_a?(Expense) && o.date.day <= Date.today.day}.group_by{|o| o.date.month}.map do |month, operations|
        index = Date.today.month - month < 0 ? (Date.today.month - month + 9).abs : (Date.today.month - month - 3).abs
        grouped_operations_for_view[index] = operations.map{|o| o.amount}.sum.round(2)
      end

      @datasets = [
        [I18n.t('operations.expense'), grouped_operations_for_view]
      ]

      g.labels = {
          0 => I18n.t("date.month_names")[(Date.today - 3.month).month],
          1 => I18n.t("date.month_names")[(Date.today - 2.month).month],
          2 => I18n.t("date.month_names")[(Date.today - 1.month).month],
          3 => I18n.t("date.month_names")[Date.today.month] ,
      }

      @datasets.each do |data|
        g.data(data[0], data[1])
      end

      g.minimum_value = 0

      filename = "test-#{SecureRandom.hex(8)}.png"
      filepath = Rails.root.join(dir, filename)
      g.write(filepath)
      photo_data = File.read(filepath)
    end

    photo_data
  end

end