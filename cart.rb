require "CSV"
require "fileutils"
require "./utils.rb"

class Cart
    attr_reader :list

    def initialize
        @list = []
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
                csv << "Sales Taxes: #{Utils.format_decimal_fraction(total_sales_tax.round(2))}".parse_csv
                csv << "Total: #{Utils.format_decimal_fraction(total_price.round(2))}".parse_csv
            end
            puts "Exported to " + file_output + "!"
        else 
            puts "Where output?"
        end
    end
end