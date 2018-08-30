require 'ox'

module EndiciaLabelServer
  module Builders
    # The {BuilderBase} class builds Endicia XML Objects.
    #
    # @author Paul Trippett
    # @since 0.1.0
    # @abstract
    # @attr [Ox::Document] document The XML Document being built
    # @attr [Ox::Element] root The XML Root
    class BuilderBase
      include Ox
      include Exceptions

      attr_accessor :document,
                    :root

      # Initializes a new {BuilderBase} object
      #
      # @param [String] root_name The Name of the XML Root
      # @return [void]
      def initialize(root_name, opts = {}, root_attributes = nil)
        initialize_xml_roots(root_name)
        assign_root_attributes(root_attributes) if root_attributes

        document << root

        opts.each_pair { |k, v| add(k, v, root) }
      end

      def add(key, value, parent_element = nil)
        parent = parent_element || root
        element_key = (key.is_a? String) ? key : Util.camelize(key)

        return add_hash_values(parent, element_key, value) if value.is_a?(Hash)
        return add_array_items(parent, element_key, value) if value.is_a?(Array)
        return add_single_element(parent, element_key, value)
      end

      # Returns a String representation of the XML document being built
      #
      # @return [String]
      def to_xml(opts = {})
        Ox.to_xml(document, opts)
      end

      def to_http_post
        "#{post_field}=#{to_xml}"
      end

      private

      def add_hash_values(parent_element, key, value)
        parent_element << Element.new(key).tap do |element|
          value.each_pair { |child_key, child_value| add(child_key, child_value, element) }
        end
      end

      def add_single_element(parent_element, key, value)
        parent_element << element_with_value(key, value)
      end

      def add_array_items(parent_element, key, value)
        parent_element << Element.new(key).tap do |element|
          value.each do |array_item|
            array_item.each_pair do |child_key, child_value|
              add(child_key, child_value, element)
            end
          end
        end
      end

      def assign_root_attributes(root_attributes)
        root_attributes.each do |attr_key, attr_value|
          root_attribute_key = Util.camelize(attr_key)
          root[root_attribute_key] = attr_value
        end
      end

      def initialize_xml_roots(root_name)
        self.document = Document.new
        self.root = Element.new(root_name)
      end

      def element_with_value(name, value)
        fail InvalidAttributeError, name unless value.respond_to?(:to_str)
        Element.new(name).tap do |request_action|
          request_action << value.to_str
        end
      end
    end
  end
end
