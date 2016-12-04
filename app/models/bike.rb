class Bike < ActiveRecord::Base

  def self.search(search)
    query = []
    query.push("name LIKE ? AND style LIKE ?")
    query.push("%#{search[:name]}%")
    query.push("%#{search[:style]}%")
    if search[:name] || search[:style] || search[:max_price] || search[:min_price]
      if search[:min_price] != ''
        query[0] = query[0] + " AND price > ?"
        query.push("#{search[:min_price]}")
      end
      if search[:max_price] != ''
        query[0] = query[0] + "AND price < ?"
        query.push("#{search[:max_price]}")
      end
      where(query).order("#{search[:order]}")
    else
      all
    end
  end
end
