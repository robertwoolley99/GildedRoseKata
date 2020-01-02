# frozen_string_literal: true

# Object to manage Gilded Rose
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.name.include? 'ulfuras'

      item.quality = decision_branch(item)
      item.sell_in -= 1
    end
  end

  private

  def decision_branch(item)
    if (item.name.include? 'ackstage') || (item.name.include? 'Aged Brie')
      edge_cases(item.name, item.sell_in, item.quality)
    else
      main_cases(item.name, item.sell_in, item.quality)
    end
  end

  def edge_cases(name, sell_in, quality)
    return quality + 1 if (name.include? 'Aged Brie') && (quality < 50)

    backstage(quality, sell_in) if name.include? 'ackstage'
  end

  def main_cases(name, sell_in, quality)
    conjure_factor = 1
    conjure_factor = 2 if name.include? 'onjured'
    adjusted = if sell_in > 1
                 (quality - (1 * conjure_factor))
               else
                 (quality - (2 * conjure_factor))
               end
    adjusted = 0 if adjusted.negative?
    adjusted
  end

  def backstage(quality, sell_in)
    return 0 if sell_in < 1

    quality = if (sell_in < 11) && (sell_in > 5)
                (quality + 2)
              else
                (quality + 3)
              end
    return 50 if quality > 50

    quality
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
