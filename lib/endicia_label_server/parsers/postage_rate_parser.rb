module EndiciaLabelServer
  module Parsers
    class PostageRateParser < ParserBase
      attr_accessor :rated_shipments

      def initialize
        super
        self.rated_shipments = []
        @current_rate = {}
      end

      def start_element(name)
        super
      end

      def end_element(name)
        super
        return unless name == :Postage
        rated_shipments << @current_rate
        @current_rate = {}
      end

      def value(value)
        super
        if switch_active?(:Postage, :MailService)
          parse_mail_service value
        elsif switch_active?(:Postage, :Rate)
          parse_total_charges value
        end
      end

      def parse_mail_service(value)
        service_code = EndiciaLabelServer::SERVICES.invert[value.as_s]
        @current_rate[:service_code] = service_code
        @current_rate[:service_name] = value.as_s
      end

      def parse_total_charges(value)
        @current_rate[:total] = value.as_s
      end
    end
  end
end
