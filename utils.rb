class Utils
    def self.format_decimal_fraction number, size = 2
        (number / 1).to_i.to_s + '.' + (number % 1 * (10**size)).to_i.to_s
    end
end