require "CSV"
require "fileutils"

class Cart
    attr_reader :list

    def initialize
        @list = []
        # @file_output = file_output
        # input_arrs = CSV.read(file_input)
        # for i in 0...input_arrs.size
        #     if i != 0
        #         item = CartDetail.new input_arrs[i][0],input_arrs[i][1],input_arrs[i][2]
        #         item.calculate_tax
        #         # item.show
        #         add_item item
        #     end
        # end
    end

    def add_item item
        @list << item
    end

    def total_sales_tax
        total = @list.inject(0) do |sum, item| 
            sum + item.tax_price
        end
        total
    end

    def total_price
        total = @list.inject(0) do |sum, item| 
            sum + item.new_price
        end
        total
    end

    def export file_output
        if (file_output) 
            folder = file_output.split("/")
            folder.pop
            folder_path = folder.join("/")
            if Dir.exist?(folder_path) == false
                FileUtils::mkdir_p folder.join("/")
            end
            CSV.open(file_output, "wb") do |csv|
                @list.each do |item|
                    csv << item.convert_csv
                end
                csv << "\n".parse_csv
                csv << "Sales Taxes: #{total_sales_tax.round(2)}".parse_csv
                csv << "Total: #{total_price.round(2)}".parse_csv
            end
            puts "Exported to " + file_output + "!"
        else 
            puts "Where output?"
        end
    end
end