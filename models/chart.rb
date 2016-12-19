require_relative('calc.rb')
require_relative('tag.rb')
require('gchart')

class MoneyChart

#refactor
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

end