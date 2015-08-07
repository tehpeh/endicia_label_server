require 'ox'

module EndiciaLabelServer
  module Builders
    class ChangePassPhraseBuilder < BuilderBase
      include Ox

      def initialize(opts = {})
        super 'ChangePassPhraseRequest', opts
        root[:TokenRequested] = 'false'
      end

      def post_field
        'ChangePassPhraseRequestXML'
      end
    end
  end
end
