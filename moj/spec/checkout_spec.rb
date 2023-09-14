# frozen_string_literal: true

require_relative '../lib/checkout'

RSpec.describe Checkout do
  let(:checkout) { Checkout.new }

  context 'with invalid items' do
    it 'ignores invalid items' do
      checkout.scan('FR1')
      checkout.scan('InvalidItem')
      checkout.scan('SR1')
      checkout.scan('InvalidItem')
      expect(checkout.calculate_total).to eq(8.11)
    end
  end

  context 'when calculating the total price' do
    it 'calculates the total for a single item' do
      checkout.scan('FR1')
      expect(checkout.calculate_total).to eq(3.11)
    end

    it 'calculates the total for multiple items' do
      checkout.scan('FR1')
      checkout.scan('SR1')
      checkout.scan('CF1')
      expect(checkout.calculate_total).to eq(19.34)
    end

    it 'calculates the total with volume discount for 3 items' do
      checkout.scan('SR1')
      checkout.scan('SR1')
      checkout.scan('SR1')
      expect(checkout.calculate_total).to eq(13.50)
    end

    it 'calculates the total with volume discount for 4 items' do
      checkout.scan('SR1')
      checkout.scan('SR1')
      checkout.scan('SR1')
      checkout.scan('SR1')
      expect(checkout.calculate_total).to eq(18.00)
    end

    it 'applies buy-one-get-one-free discount correctly' do
      checkout.scan('FR1')
      checkout.scan('FR1')
      checkout.scan('FR1')
      expect(checkout.calculate_total).to eq(6.22)
    end

    it 'calculates the total with multiple discounts' do
      checkout.scan('SR1')
      checkout.scan('SR1')
      checkout.scan('SR1')
      checkout.scan('CF1')
      checkout.scan('FR1')
      checkout.scan('FR1')
      expect(checkout.calculate_total).to eq(27.84)
    end

    it 'handles items without discounts' do
      checkout.scan('CF1')
      expect(checkout.calculate_total).to eq(11.23)
    end

    it 'handles an empty cart' do
      expect(checkout.calculate_total).to eq(0)
    end
    # Add more test cases as needed
  end
end
