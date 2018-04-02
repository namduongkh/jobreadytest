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
    end

    describe "#new" do
        it "Tạo mới Cart" do
            expect(@cart).to be_an_instance_of Cart
        end
    end

    describe "#add_item" do
        it "Thêm detail" do
            items.each do |item|
                detail = CartDetail.new item[0], item[1], item[2]
                detail.calculate_tax
                @cart.add_item detail
            end
            expect(@cart.list.size).to eq(4)
        end
    end

    describe "#total_price" do
        it "Tổng tiền" do
            items.each do |item|
                detail = CartDetail.new item[0], item[1], item[2]
                detail.calculate_tax
                @cart.add_item detail
            end
            expect(@cart.total_price.round(2)).to eq(74.68)
        end
    end

    describe "#total_sales_tax" do
        it "Tổng tiền" do
            items.each do |item|
                detail = CartDetail.new item[0], item[1], item[2]
                detail.calculate_tax
                @cart.add_item detail
            end
            expect(@cart.total_sales_tax.round(2)).to eq(6.7)
        end
    end
end