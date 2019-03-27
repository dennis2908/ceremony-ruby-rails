class BiblePrayer < ApplicationRecord

  def is_not_first
    BiblePrayer.exists?(self.id - 1)
  end

  def is_not_last
    BiblePrayer.exists?(self.id + 1)
  end 
end
