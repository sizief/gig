require_relative 'gateway'
require 'colorize'

module Gig

  class CLI
    def initialize args 
      api_results = Gateway.call(args)
      if api_results[:code] == 200
        puts "Connecting to Github complete! Downloading images now".colorize(:green)
        downloader = Downloader.new Gig::Helper::extract_image_urls(api_results[:body]), args.join("-")
        downloader.save_all
      else
        puts api_results[:body].colorize(:red)
      end
    end
  end

end
# TODO: give more options to users by using 'optparse'
# TODO: separate the logic from CLI so we can use Gig with more interfaces