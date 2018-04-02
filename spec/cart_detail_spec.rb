require "spec_helper"

describe CartDetail do
    before :each do
        @detail = CartDetail.new(1, "book", 12.49)
    end

    describe "#new" do
        it "Tạo mới CartDetail" do
            expect(@detail).to be_an_instance_of CartDetail
        end
    end

    describe "#calculate_tax" do
        it "Tính thuế" do
            @detail.calculate_tax
            expect(@detail.new_price).to eq 12.49
            expect(@detail.tax_percent).to eq 0
        end
    end
end