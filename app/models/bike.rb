class Bike < ActiveRecord::Base

  def self.search(search)
    if search[:name] || search[:style]
      where(["    name LIKE ?
              AND style LIKE ?
              AND price BETWEEN ? AND ?",
              "%#{search[:name]}%",
              "%#{search[:style]}%",
              "#{search[:min_price]}",
              "#{search[:max_price]}"]).
      order("#{search[:order]}")
    else
      all
    end
  end
end
