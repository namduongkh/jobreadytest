require "spec_helper"

describe CartDetail do
    before :each do
        @detail = CartDetail.new(1, "book", 12.49)
    end

    describe "#new" do
        it "new CartDetail" do
            expect(@detail).to be_an_instance_of CartDetail
        end
    end

    describe "#detail product" do
        it "detail product" do
            expect(@detail.product).to eq "book"
        end
    end

    describe "#calculate_tax" do
        it "calculate tax" do
            @detail.calculate_tax
            expect(@detail.new_price).to eq 12.49
            expect(@detail.tax_percent).to eq 0
        end
    end
end