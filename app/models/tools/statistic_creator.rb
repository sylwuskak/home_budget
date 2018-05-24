class Tools::StatisticCreator
  
  def initialize(categories, operations)
    require 'gruff'

    @categories = categories
    @operations = operations
  end

  def full_statistics
    photo_data = ''
    
    Dir.mktmpdir do |dir|
      grouped_operations = @operations.select{|o| o.type == 'Expense'}.group_by{|o| o.category}
      
      datasets = grouped_operations.map do |category, operations|
        [category.category_name, [operations.map{|o| o.amount}.sum]]
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