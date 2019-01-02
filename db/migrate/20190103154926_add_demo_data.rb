class AddDemoData < ActiveRecord::Migration[5.0]
  def change
    
    user = User.where(email: "demo@example.com").first

    (Date.new(2019, 1, 1)..Date.new(2019, 12, 31)).each do |d|
      Expense.create!(
        user: user, 
        date: d, 
        category: user.categories.select{|c| c.category_type == 'Expense'}.sample,
        amount: (1..100).to_a.sample,
        description: ''
      )
      if d.day == 1 
        Incoming.create!(
          user: user, 
          date: d, 
          category: user.categories.select{|c| c.category_type == 'Incoming'}[1],
          amount: 2500,
          description: ''
        )

        user.categories.select{|c| c.category_type == 'Expense'}.each do |c|
          Budget.create!(
            user: user,
            date: d, 
            category: c,
            amount: (50..1000).to_a.sample
          )
        end
        
      end

    end




  end
end
