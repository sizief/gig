require 'rest-client'

module Gig
  
  class Downloader 

    TIME_VALIDITY = 60*60.to_f #images are valid if downloaded within recent one hour
    def initialize urls, destination
      @urls = urls
      @destination = destination
    end

    def save_all
      threads = Array.new
      create_folder
      @urls.each do |url|
        threads << Thread.new { save url }
      end

      threads.each do |thread|
        thread.join  
      end 
    end

    private
    def create_folder
      unless @urls.empty?
        Dir.mkdir @destination unless File.directory? @destination
      end
    end

    def save url
      unless image_exists url
        begin
          res = RestClient.get url
          file_name = Gig::Helper::remote_file_name(url, res)
          File.write("#{@destination}/#{file_name}", res.body)
          puts "- #{file_name} downloaded successfully!".colorize(:green)
        rescue
        end
      end
    end

    def image_exists url
      file_name = url.split("/")[-1]
      result = false
      if Dir["#{@destination}/*-#{file_name}*"].any?
        file_timestamp = Dir.glob("#{@destination}/*-#{file_name}*").first.split("/")[-1].split("-").first.to_i
        result = true if file_timestamp > (Time.now - TIME_VALIDITY).to_i #check if file older than certain amount of time
      end  
      result
    end

  end

end
  
