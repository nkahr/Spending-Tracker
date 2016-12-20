require_relative('calc.rb')
require_relative('tag.rb')
require('gchart')
require('date')

class MoneyChart

  def self.pie_chart(transactions_array)
    tags = Tag.all()
    labels = []
    totals = []
    for tag in tags
      total = Calc.total_by_id(transactions_array, tag.id)
      if total > 0
        labels.push(tag.label)
        totals.push(total)
      end
    end
    chart_url = Gchart.pie({:data => totals, :labels => labels})
    return chart_url
  end

  def self.spending_per_day_bar_chart(user)
    data = Calc.spending_per_day(user)
    days = Date::ABBR_DAYNAMES
    chart_url = Gchart.bar({:data => data, :labels => days})
    return chart_url
  end


  # def self.spending_per_category_bar_chart(user)
  #   transactions = user.transactions
  #   days = Date::ABBR_DAYNAMES
  #   data_arr = []
  #   tags = transactions.map{|t| Tag.find_by_id(t.tag_id)}
  #   Date::DAYNAMES.each do |day|
  #     t_in_day = transactions.find_all{|t| Date.parse(t.time).strftime("%A") == day}
  #     data = []
  #     for tag in tags 
  #       selected = t_in_day.find_all{|transaction| transaction.tag_id == tag.id}      
  #       total = selected.inject(0){|sum, t| sum += t.amount}
  #       data.push(total.round(2))
  #     end
  #     data_arr.push(data)
  #   end
  #   chart_url = Gchart.bar({:data => data_arr, :labels => days, :bar_colors => ['FF0000', '00FF00', 'FF0000', '00FF00', 'FF0000', '00FF00', 'FF0000'] })
  # end
end