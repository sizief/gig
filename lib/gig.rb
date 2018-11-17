require "gig/version"
require "gig/cli"
require "gig/downloader"

require "json"

module Gig
  module Helper
    def self.extract_image_urls document
      json = JSON.parse document
      results = Array.new

      json["items"].each do |element|
         results << element["owner"]["avatar_url"]
      end
      results
    end

    def self.remote_file_name file
      file.base_uri.to_s.split('/')[-1] + "." + Gig::Helper::format_name(file.content_type)
    end

    def self.format_name content_type
      case content_type
      when "image/png"
        return "png"
      when "image/jpeg"
        return "jpeg"
      when "image/jpg"
        return "jpg"
      else
        return content_type.split('/')[-1]
      end
    end
  end
end
