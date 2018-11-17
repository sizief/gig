require 'open-uri'

module Gig
  
  class Downloader 
    def initialize urls, destination
      @urls = urls
      @destination = destination
    end

    private
    def create_folder
      unless @urls.empty?
        Dir.mkdir @destination unless File.directory? @destination
      end
    end

    def save url
      image_file = open(url) 
      IO.copy_stream(image_file, "#{@destination}/#{Gig::Helper::remote_file_name(image_file)}")
    end

  end

end
  
