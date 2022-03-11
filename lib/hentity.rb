# frozen_string_literal: true

require_relative "hentity/version"

def require_dir(dir)
  Dir.entries(dir).reject { |f| %w[. ..].include?(f) }.each do |path|
    dir_path = "#{dir}/#{path}"

    if path.split('.').last == 'rb'
      require_relative dir_path
    elsif File.directory?(dir_path)
      require_dir(dir_path)
    else
      break
    end
  end
end

require_dir "#{__dir__}/hentity"

module Hentity
  Hentity::Logger.configure(
    colorize: true,
    output: :stdout
  )
end


class SEntity2 < Hentity::Entity
  float :id, exactly: false
  integer :uaid, exactly: false
  boolean :b
end

SEntity2.new({uaid:  true})
