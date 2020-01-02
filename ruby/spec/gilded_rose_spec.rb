# frozen_string_literal: true

require 'gilded_rose.rb'

describe GildedRose do
  describe 'update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
    it 'increases the quality of Aged Brie' do
      items = [Item.new('Aged Brie', 2, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 1
    end
    it 'reduces the quality by twice as much when the sell by date \
    has passed' do
      items = [Item.new('Elixir of the Mongoose', 0, 20)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 18
    end
    it 'Never reduces quality for Sulfuras' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 30, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 80
    end
  end
end

describe GildedRose do
  describe 'check for edge cases around quality' do
    it 'never allows quality to go below zero for regular items' do
      items = [Item.new('Elixir of the Mongoose', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
  end
  it 'deducts quality at the rate of 2 for in-date conjured items' do
    items = [Item.new('Conjured Mana Cake', 3, 6)]
    GildedRose.new(items).update_quality
    expect(items[0].quality).to eq 4
  end
end

describe GildedRose do
  describe 'update quality for backstage passes' do
    it 'backstage passes go to 0 after concert' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
    it 'does not let quality to go negative' do
      items = [Item.new('Backstage passes to a concert', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
    it 'backstage passes increase in quality by 2 when there are 10 - 6 days \
    left' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
    end
    it 'backstage passes increase in quality by 3 when there are fewer than \
    5 days left' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 5
    end
  end
end

describe GildedRose do
  describe 'checks for decrementing of days to sell' do
    it 'works on a plain vanilla product' do
      items = [Item.new('Elixir of the Mongoose', 0, 20)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq -1
    end
    it 'works on a backstage pass' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 4
    end
    it 'Never reduces sellby for Sulfuras' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 30, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 30
    end
  end
end
