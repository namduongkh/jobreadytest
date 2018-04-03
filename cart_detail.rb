EXCEPT_SALES_TAX_10 = ["chocolate", "chocolates", "book", "pills"]
SALES_TAX_5 = ["imported", "import"]

class CartDetail
    attr_reader :tax_percent, :new_price, :tax_price, :product

    def initialize quantity, product, price
        @quantity = quantity.to_i
        @product = product.strip
        @price = price.to_f
        # calculate_tax
    end

    def calculate_tax
        @tax_percent = calculate_tax_percent
        @tax_price = calculate_tax_price(@tax_percent).round(2)
        @new_price = calculate_new_price(@tax_price).round(2)
    end

    # def show
    #     print "Quantity: #{@quantity}, Product: #{@product}, Price: #{@price}, Tax: #{@tax} \n"
    # end

    def convert_csv
        "#{@quantity}, #{@product}, #{format_decimal_fraction(@new_price)}".parse_csv
    end

    private
    def round_nearest number, nearest = 0.05
        nearest * (number / nearest).ceil
    end

    def calculate_tax_percent
        tax = 10;
        is_excepted = false
        is_sales_tax_5 = false

        split_product_arr = @product.split
        for i in 0...split_product_arr.length
            if is_excepted == false
                if EXCEPT_SALES_TAX_10.index split_product_arr[i]
                    is_excepted = true;
                    tax -= 10;
                end
            end
            if is_sales_tax_5 == false
                if SALES_TAX_5.index split_product_arr[i]
                    is_sales_tax_5 = true;
                    tax += 5
                end
            end
            break if is_excepted && is_sales_tax_5
        end
        tax
    end

    def calculate_tax_price tax_percent = 0
        round_nearest((@price * @quantity) / 100 * tax_percent)
    end

    def calculate_new_price tax_price = 0
        @price + tax_price
    end

    def format_decimal_fraction number, size = 2
        (number / 1).to_i.to_s + '.' + (number % 1 * (10**size)).to_i.to_s
    end
end
