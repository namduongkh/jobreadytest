require "spec_helper"

items = [
    [1, "imported bottle of perfume", 27.99],
    [1, "bottle of perfume", 18.99],
    [1, "packet of headache pills", 9.75],
    [1, "box of imported chocolates", 11.25],
]

describe Cart do

    before :each do
        @cart = Cart.new
        items.each do |item|
            detail = CartDetail.new *item
            detail.calculate_tax
            @cart.add_item detail
        end
    end

    describe "#new" do
        it "new Cart" do
            expect(@cart).to be_an_instance_of Cart
        end
        context "with no parameters" do
            it "has no books" do
                cart = Cart.new
                expect(cart.list.size).to eq(0)
            end
        end
        context "with a yaml file parameter" do
            it "has five books" do
                expect(@cart.list.size).to eq(4)
            end
        end
    end

    describe "#add_item" do
        it "add cart detail" do
            detail = CartDetail.new 1, "refrigerator", 250
            detail.calculate_tax
            @cart.add_item detail
            expect(@cart.list.size).to eq(5)
        end
    end

    describe "#total_price" do
        it "total price" do
            expect(@cart.total_price.round(2)).to eq(74.68)
        end
    end

    describe "#total_sales_tax" do
        it "total sales tax" do
            expect(@cart.total_sales_tax.round(2)).to eq(6.7)
        end
    end
end