require_relative 'gateway'
module Gig

  class CLI
    def initialize args 
      api_results = Gateway.call(args)
      if api_results[:code] == 200
        #puts Gig::Helper::extract_image_urls api_results[:body]
        puts "Connecting to Github complete! Downloading images now"
        downloader = Downloader.new Gig::Helper::extract_image_urls(api_results[:body]), args.join("-")
        downloader.save_all
      else
        puts api_results[:body]
      end
    end
  end

end
  