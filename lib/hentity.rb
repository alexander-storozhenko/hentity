# frozen_string_literal: true

require_relative "hentity/version"

def require_dir(dir)
  Dir["#{dir}/*.rb"].sort.each {|file| require_relative file }
end

MAIN_DIR = "#{__dir__}/hentity".freeze

require_dir MAIN_DIR
require_dir "#{MAIN_DIR}/errors"

module Hentity
  Hentity::Logger.configure(
    colorize: true,
    output: :stdout,
    timestamp_format: '%FT%T%Z'
  )
end

class Model < Hentity::Entity
  integer :id
end