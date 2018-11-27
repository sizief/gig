require 'rest-client'
require 'thread/pool'

module Gig
  
  class Downloader 

    TIME_VALIDITY = 60*60.to_f #images are valid if downloaded within recent one hour
    THREAD_LIMIT = 10.to_i #change this based on your hard drive IO capability and internet bandwidth
    
    def initialize urls, destination
      @urls = urls
      @destination = destination
    end

    #download and save files in THREAD_LIMIT item batches, because we don't have any queue system to save failed requests,
    #it if better to be cautious and think of IO and bandwidth limits.
    #TODO: add something like Sidekiq to retry failed requests.
    def save_all
      pool = Thread.pool(THREAD_LIMIT)
      create_folder
      @urls.each do |url|
        pool.process {save url} 
      end
      pool.shutdown
    end

    private
    def create_folder
      unless @urls.empty? # we don't need to create folders for empty requests
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
  
