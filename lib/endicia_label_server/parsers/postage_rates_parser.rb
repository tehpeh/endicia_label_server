module EndiciaLabelServer
  module Parsers
    class PostageRatesParser < PostageRateParser
      def attr_value(name, value)
        @current_rate[:total] = value.as_s if name == :TotalAmount
      end
    end
  end
end
