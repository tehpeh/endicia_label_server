module EndiciaLabelServer
  module Util
    class << self
      def camelize(value)
        value.to_s.split('_').map { |v| capitalize_with_id_exception(v) }.join
      end

      def capitalize_with_id_exception(value)
        (value == 'id') ? 'ID' : value.capitalize
      end
    end
  end
end
