# frozen_string_literal: true

# The Checkout class represents a shopping cart checkout system.
# It allows you to scan items, calculate the total price, and apply discounts.
class Checkout
  def initialize
    @cart = []
    @prices = {
      'FR1' => 3.11,  # Fruit tea
      'SR1' => 5.00,  # Strawberries
      'CF1' => 11.23  # Coffee
      # add more prices here
    }
    @discounts = {
      'FR1' => { type: :buy_one_get_one_free, discounted_price: 3.11 }, # Buy one, get one free for Fruit tea
      'SR1' => { type: :volume_discount, quantity: 3, discounted_price: 4.50 } # Bulk discount for Strawberries
      # add more discounts here
      # "CF1" => { type: :buy_two_get_one_free, discounted_price: 11.23 },  # Buy two, get one free for Coffee example
    }
  end

  # Scan an item and add it to the cart.
  def scan(item)
    if @prices.key?(item)
      @cart << item
    else
      puts "Invalid item: #{item}"
    end
  end

  # Calculate the total price of all items in the cart.
  def calculate_total
    total = 0
    item_counts = count_items

    item_counts.each do |item, count|
      total += calculate_item_total(item, count)
    end

    total.round(2)
  end

  def count_items
    item_counts = Hash.new(0)
    @cart.each do |item|
      item_counts[item] += 1
    end
    item_counts
  end

  # Calculate the total price of a specific item.
  def calculate_item_total(item, count)
    if @discounts.key?(item)
      discount = @discounts[item]
      if discount[:type] == :buy_one_get_one_free
        return calculate_bogo_discount(item, count)
      elsif discount[:type] == :volume_discount && count >= discount[:quantity]
        return calculate_volume_discount(item, count)
      end
    end

    calculate_regular_price(item, count)
  end

  # Methods to calculate the total price for each discount type. consider making these private.

  # Buy one, get one free.
  def calculate_bogo_discount(item, count)
    discounted_items = (count / 2).floor
    remaining_items = count % 2
    (discounted_items * @prices[item]) + (remaining_items * @prices[item])
  end

  # Bulk discount.
  def calculate_volume_discount(item, count)
    discount = @discounts[item][:discounted_price]
    count * discount
  end

  # add further discount methods here

  # No discount.
  def calculate_regular_price(item, count)
    count * @prices[item]
  end
end

# Example usage:
checkout = Checkout.new
checkout.scan('SR1')
checkout.scan('SR1')
checkout.scan('SR1')
checkout.scan('CF1')
checkout.scan('FR1')
checkout.scan('jk5')

# sr1 * 3 = 13.50
# cf1 = 11.23
# fr1 = 3.11
# jk5 = invalid
# total = 27.84

total_price = checkout.calculate_total
puts "Total Price: £#{total_price}"
