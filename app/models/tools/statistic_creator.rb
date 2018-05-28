class Tools::StatisticCreator
  
  def initialize(categories, operations)
    require 'gruff'

    @categories = categories
    @operations = operations
  end

def general_statistics
    expenses_sum = @operations.select{|o| o.is_a? Expense}.map{|o| o.amount}.sum.round(2)
    incomings_sum = @operations.select{|o| o.is_a? Incoming}.map{|o| o.amount}.sum.round(2)
    
    grouped_expenses_operations = @operations.select{|o| o.is_a? Expense}.group_by{|o| o.category_id}.map do |category_id, operations|
      {category_id: category_id, category: @categories.find(category_id).category_name, sum: operations.map{|o| o.amount}.sum.round(2), operations: operations}
    end.sort_by{|h| -h[:sum]}

    grouped_incomings_operations = @operations.select{|o| o.is_a? Incoming}.group_by{|o| o.category_id}.map do |category_id, operations|
      {category_id: category_id, category: @categories.find(category_id).category_name, sum: operations.map{|o| o.amount}.sum.round(2), operations: operations}
    end.sort_by{|h| -h[:sum]}

    {expenses_sum: expenses_sum, incomings_sum: incomings_sum, grouped_expenses_operations: grouped_expenses_operations, grouped_incomings_operations: grouped_incomings_operations}
  end

  def full_statistics
    photo_data = ''
    
    Dir.mktmpdir do |dir|
      grouped_operations = @operations.select{|o| o.type == 'Expense'}.group_by{|o| o.category_id}
      
      datasets = grouped_operations.map do |category_id, operations|
        [@categories.find(category_id).category_name, [operations.map{|o| o.amount}.sum]]
      end

      g = Gruff::Pie.new
      g.theme = Gruff::Themes::PASTEL
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

  def first_test
    photo_data = ''

    Dir.mktmpdir do |dir|
      @datasets = [
        [:Darren, [25]],
        [:Chris, [80]],
        [:Egbert, [22]],
        [:Adam, [95]],
        [:Bill, [90]],
        ["Frank", [5]],
        ["Zero", [0]],
        ]

      g = Gruff::Pie.new
      g.title = "Visual Pie Graph Test"
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