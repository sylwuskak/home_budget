class Tools::OperationFileImporter
  def self.import(file, current_user)
    self.new(file, current_user).import
  end
    
  def initialize(file, current_user)
    @file = Nokogiri::HTML(file, nil, Encoding::UTF_8.to_s)
    @current_user = current_user
    @categories = current_user.categories 
    @configuration = current_user.configurations.first
  end
    
  def import
    body = @file.at_xpath('/html/body') 
    table = body.xpath("//table//tr[@class = 'head']/td").find{|n| n.text =~ /data operacji/i}.parent.parent
    rows = table.xpath('tr') 
    rows[2..-2].each do |row|
      tds = row.xpath('td')
      date = tds[0].text
      description = tds[2].text
      amount = tds[3].text.gsub(',', '.').gsub(' ', '').to_f

      unless check_if_unnecessary(description)
        category = find_category(description, amount)
        Operation.create!(
          user: @current_user,
          category: category,
          date: date,
          type: (amount > 0) ? 'Incoming' : 'Expense',
          amount: amount.abs,
          description: description
        )
      end
    end
  end

  def find_category(category_description, amount)
    correct_categories = @categories.select{|c| (amount > 0) ? c.category_type == 'Incoming' : c.category_type ==  'Expense'} 
    
    correct_categories.each do |c|
      c.keyword.to_s.split(';').each do |k|
        if category_description.downcase.include? k.downcase
          return c 
        end
      end
    end

    correct_categories.first
  end

  def check_if_unnecessary(category_description)
    @configuration.keyword.to_s.split(';').each do |k|
      if category_description.downcase.include? k.downcase
        return true
      end
    end
    false
  end
end