class Checkout
  def initialize
    @cart = []
    @prices = {
      "FR1" => 3.11,  # Fruit tea
      "SR1" => 5.00,  # Strawberries
      "CF1" => 11.23  # Coffee
    }
    @discounts = {
      "FR1" => { type: :buy_one_get_one_free, discounted_price: 3.11 },  # Buy one, get one free for Fruit tea
      # "CF1" => { type: :buy_two_get_one_free, discounted_price: 11.23 },  # Buy two, get one free for Coffee example
      "SR1" => { type: :volume_discount, quantity: 3, discounted_price: 4.50 }  # Bulk discount for Strawberries
    }
  end

  def scan(item)
    @cart << item
  end

  def calculate_total
    total = 0
    item_counts = Hash.new(0)

    @cart.each do |item|
      item_counts[item] += 1
    end

    item_counts.each do |item, count|
      if @discounts.key?(item)
        discount = @discounts[item]
        if discount[:type] == :buy_one_get_one_free
          discounted_items = (count / 2).floor
          remaining_items = count % 2
          total += (discounted_items * discount[:discounted_price]) + (remaining_items * @prices[item])
        elsif discount[:type] == :volume_discount && count >= discount[:quantity]
          discounted_items = count * discount[:discounted_price]
          total += discounted_items
        end

      else
        total += count * @prices[item]
      end
    end

    total.round(2)
  end
end

# Example usage:
checkout = Checkout.new
checkout.scan("FR1")
checkout.scan("SR1")
checkout.scan("FR1")
checkout.scan("CF1")
checkout.scan("SR1")
checkout.scan("SR1")
checkout.scan("FR1")
checkout.scan("FR1")
checkout.scan("FR1")
checkout.scan("FR1")
checkout.scan("FR1")
checkout.scan("SR1")
checkout.scan("CF1")


# 7 Fruit teas at £3.11 each = £12.44
# 4 Strawberries at £5.00 each = £18.00
# 2 Coffees at £11.23 each = £22.46
# Total = £50.90

total_price = checkout.calculate_total
puts "Total Price: £#{total_price}"
