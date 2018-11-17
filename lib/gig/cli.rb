require_relative 'gateway'
module Gig

  class CLI
    def initialize args 
      api_results = Gateway.call(args)
      if api_results[:code] == 200
        puts Gig::Helper::extract_image_urls api_results[:body]
        Downloader.all api_results[:body], args.join("-")
      else
        puts api_results[:body]
      end
    end
  end

end
  