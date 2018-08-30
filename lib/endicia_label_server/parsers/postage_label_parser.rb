require 'base64'

module EndiciaLabelServer
  module Parsers
    class PostageLabelParser < ParserBase
      attr_accessor :pic,
                    :customs_number,
                    :tracking_number,
                    :final_postage,
                    :transaction_id,
                    :transaction_date_time,
                    :postmark_date,
                    :postage_balance,
                    :cost_center,
                    :requester_id,
                    :label

      def start_element(name)
        super
        @current_element = name.to_s
      end

      def value(value)
        super

        element = underscore(@current_element)
        string_value = value.as_s
        if label_switch_active?
          parse_label(string_value)
        else
          function_name = "#{element}="
          send(function_name, string_value) if respond_to?(function_name)
        end
      end

      def label_switch_active?
        switch_active?(:Base64LabelImage) || (switch_active?(:Label, :Image) && current_attributes[:PartNumber] == '1')
      end

      def underscore(value)
        value.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase
      end

      def parse_label(encoded_label)
        label_file = Tempfile.new(['endicia', '.png'])
        label_file.binmode
        label_file.write(Base64.decode64(encoded_label))
        label_file.rewind
        self.label = label_file
      end
    end
  end
end
