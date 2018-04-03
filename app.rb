require "CSV"
require "./cart"
require "./cart_detail"

files = [
    { 
        in: "inputs/1.csv" ,
        out: "outputs/1.csv" 
    },
    { 
        in: "inputs/2.csv" ,
        out: "outputs/2.csv" 
    },
    { 
        in: "inputs/3.csv" ,
        out: "outputs/3.csv" 
    },
]

files.each do |file|
    cart = Cart.new    
    input_arrs = CSV.read(file[:in])
    for i in 0...input_arrs.size
        if i != 0
            item = CartDetail.new input_arrs[i][0],input_arrs[i][1],input_arrs[i][2]
            item.calculate_tax
            cart.add_item item
        end
    end
    cart.export file[:out]
end