module EndiciaLabelServer
  module Parsers
    class PostageRatesParser < PostageRateParser
      def attr_value(name, value)
        @current_rate[:total] = value.as_s if name == :TotalAmount
      end

      def value(value)
        super
        if switch_active?(:MailClass)
          @current_rate[:mail_class] = value.as_s
        end
      end
    end
  end
end
