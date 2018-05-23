class Tools::OperationFileImporter
  def self.import(file, current_user)
    self.new(file, current_user).import
  end
    
  def initialize(file, current_user)
    @file = Nokogiri::HTML(file, nil, Encoding::UTF_8.to_s)
    @current_user = current_user
  end
    
  def import
    body = @file.at_xpath('/html/body') 
    table = body.xpath("//table//tr[@class = 'head']/td").find{|n| n.text =~ /data operacji/i}.parent.parent
    rows = table.xpath('tr') 
    rows[2..-2].each do |row|
      tds = row.xpath('td')
      date = tds[0].text
      description = tds[2].text
      amount = tds[3].text.gsub(',', '.').to_f

      Operation.create!(
        user: @current_user,
        category: @current_user.categories.select{|c| (amount > 0) ? c.category_type == 'Incoming' : c.category_type ==  'Expense'}.first,
        date: date,
        type: (amount > 0) ? 'Incoming' : 'Expense',
        amount: amount.abs,
        description: description
      )
    end
  end
end