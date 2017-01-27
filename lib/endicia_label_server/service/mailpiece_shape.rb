module EndiciaLabelServer
  module Service

    class MailpieceShape
      attr_accessor :service_name

      MAILPIECESHAPES.each do |mailpiece|
        define_method "#{Util.underscore(mailpiece).gsub(' ', '_')}_mailpiece" do
           mailpiece
        end
      end

      def initialize(service_name)
        @service_name = service_name
      end

      def all
        send("#{Util.underscore(service_name).gsub(' ', '_').to_sym}_mailpiece_shapes")
      end

      private

      def express_mail_mailpiece_shapes
        [flat_mailpiece, parcel_mailpiece, large_parcel_mailpiece, flat_rate_legal_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, flat_rate_gift_card_envelope_mailpiece, small_flat_rate_envelope_mailpiece]
      end

      def express_mail_international_mailpiece_shapes
        [flat_mailpiece, flat_rate_padded_envelope_mailpiece, parcel_mailpiece, flat_rate_envelope_mailpiece]
      end

      def priority_mail_express_mailpiece_shapes
        [flat_mailpiece, parcel_mailpiece, large_parcel_mailpiece, flat_rate_envelope_mailpiece]
      end

      def priority_mail_express_international_mailpiece_shapes
        [flat_mailpiece, flat_rate_padded_envelope_mailpiece, parcel_mailpiece, flat_rate_envelope_mailpiece]
      end

      def first_class_mail_mailpiece_shapes
        [letter_mailpiece, flat_mailpiece, parcel_mailpiece]
      end

      def library_mail_mailpiece_shapes
        [parcel_mailpiece]
      end

      def media_mail_mailpiece_shapes
        [parcel_mailpiece]
      end

      def standard_post_mailpiece_shapes
        [parcel_mailpiece, large_parcel_mailpiece]
      end

      def parcel_select_mailpiece_shapes
        [parcel_mailpiece, large_parcel_mailpiece]
      end

      def parcel_select_barcoded_nonpresorted_mailpiece_shapes
        [parcel_mailpiece, large_parcel_mailpiece]
      end

      def priority_mail_mailpiece_shapes
        [flat_mailpiece, parcel_mailpiece, large_parcel_mailpiece, flat_rate_legal_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, flat_rate_gift_card_envelope_mailpiece, small_flat_rate_envelope_mailpiece]
      end

      def critical_mail_mailpiece_shapes
        []
      end

      def first_class_mail_international_mailpiece_shapes
        [letter_mailpiece, flat_mailpiece, parcel_mailpiece]
      end

      def first_class_package_international_service_mailpiece_shapes
        [letter_mailpiece, flat_mailpiece, parcel_mailpiece]
      end

      def priority_mail_international_mailpiece_shapes
        [flat_mailpiece, parcel_mailpiece, flat_rate_envelope_mailpiece, flat_rate_legal_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, small_flat_rate_box_mailpiece, medium_flat_rate_box_mailpiece, large_flat_rate_box_mailpiece]
      end

      def priority_mail_express_flat_rate_envelope_mailpiece_shapes
        [flat_rate_envelope_mailpiece]
      end

      def priority_mail_flat_rate_envelope_mailpiece_shapes
        [flat_rate_envelope_mailpiece]
      end
    end
  end
end
