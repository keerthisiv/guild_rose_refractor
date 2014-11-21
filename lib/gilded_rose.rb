class GildedRose
  attr_reader :items

  def initialize item_attributes
    @items = item_attributes.map { |args| Item.new(*args) }
  end

  def update_quality

    for i in 0..(@items.size-1)
      if check_name_Backstage?(i) && check_name_Angie?(i) 
        secondary_check(i)
      else
        if (@items[i].quality < 50)
          increment_quality(i)
          if (@items[i].name == "Backstage passes to a TAFKAL80ETC concert")
            if (@items[i].sell_in < 11)
              check_quality_less_than_50(i)
            end
            if (@items[i].sell_in < 6)
              check_quality_less_than_50(i)
            end
          end
        end
      end
      update_sell_in(i)
      if (@items[i].sell_in < 0)
         check_name_Angie?(i) ?  check_name_and_quality(i) : check_quality_less_than_50(i)
      end
    end
  end

  def check_name_and_quality(index)
    check_name_Backstage?(index) ? secondary_check(index) : @items[index].quality = 0
  end

  def secondary_check(index)
    decrement_quality(index) if check_quality_greater_than_zero(index) && check_name_sulfras?(index)
  end

  def check_name_Backstage?(index)
    @items[index].name != "Backstage passes to a TAFKAL80ETC concert"
  end

  def check_name_Angie?(index)
    @items[index].name != "Aged Brie"
  end

  def check_quality_greater_than_zero(index)
    @items[index].quality > 0
  end

  def check_quality_less_than_50(index)
    if (@items[index].quality < 50)
      increment_quality(index)
    end
  end

  def check_name_sulfras?(index)
    @items[index].name != "Sulfuras, Hand of Ragnaros"
  end

  def update_sell_in(index)
    if (@items[index].name != "Sulfuras, Hand of Ragnaros")
      @items[index].sell_in = @items[index].sell_in - 1;
    end
  end

  def increment_quality(index)
    @items[index].quality = @items[index].quality + 1
  end

  def decrement_quality(index)
    @items[index].quality = @items[index].quality - 1
  end

end

