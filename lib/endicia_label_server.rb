module EndiciaLabelServer
  GEM_NAME = 'endicia_label_server'

  autoload :SERVICES,                "#{GEM_NAME}/services"
  autoload :MAILPIECESHAPES,                "#{GEM_NAME}/services"

  module Service
    autoload :MailpieceShape,          "#{GEM_NAME}/service/mailpiece_shape"
  end

  autoload :Version,               "#{GEM_NAME}/version"
  autoload :Connection,            "#{GEM_NAME}/connection"
  autoload :Exceptions,            "#{GEM_NAME}/exceptions"
  autoload :Util,                  "#{GEM_NAME}/util"

  module Builders
    autoload :BuilderBase,             "#{GEM_NAME}/builders/builder_base"
    autoload :PostageRateBuilder,      "#{GEM_NAME}/builders/postage_rate_builder"
    autoload :PostageRatesBuilder,     "#{GEM_NAME}/builders/postage_rates_builder"
    autoload :UserSignUpBuilder,       "#{GEM_NAME}/builders/user_sign_up_builder"
    autoload :PostageLabelBuilder,     "#{GEM_NAME}/builders/postage_label_builder"
    autoload :ChangePassPhraseBuilder, "#{GEM_NAME}/builders/change_pass_phrase_builder"
  end

  module Parsers
    autoload :ParserBase,              "#{GEM_NAME}/parsers/parser_base"
    autoload :PostageRateParser,       "#{GEM_NAME}/parsers/postage_rate_parser"
    autoload :PostageRatesParser,      "#{GEM_NAME}/parsers/postage_rates_parser"
    autoload :UserSignUpParser,        "#{GEM_NAME}/parsers/user_sign_up_parser"
    autoload :PostageLabelParser,      "#{GEM_NAME}/parsers/postage_label_parser"
    autoload :ChangePassPhraseParser,  "#{GEM_NAME}/parsers/change_pass_phrase_parser"
  end
end
