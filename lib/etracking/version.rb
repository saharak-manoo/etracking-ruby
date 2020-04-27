module Etracking
  VERSION_INFO = [0, 0, 1].freeze
  VERSION = VERSION_INFO.map(&:to_s).join('.').freeze

  def self.version
    VERSION
  end
end