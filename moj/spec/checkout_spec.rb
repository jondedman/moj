require_relative '../lib/checkout'

RSpec.describe Checkout do
  let(:checkout) { Checkout.new }

  context "when calculating the total price" do
    it "calculates the total for a single item" do
      checkout.scan("FR1")
      expect(checkout.calculate_total).to eq(3.11)
    end

    it "calculates the total for multiple items" do
      checkout.scan("FR1")
      checkout.scan("SR1")
      checkout.scan("CF1")
      expect(checkout.calculate_total).to eq(19.34)
    end

    context "with invalid items" do
      it "ignores invalid items" do
        checkout.scan("FR1")
        checkout.scan("InvalidItem")
        checkout.scan("SR1")
        expect(checkout.calculate_total).to eq(8.11)
      end
    end

    # Add more test cases as needed
  end
end
