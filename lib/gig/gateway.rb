require 'net/http'    

module Gig
  
  class Gateway
    def self.call args
      uri = URI("https://api.github.com/search/repositories?q=#{args.join('+')}")
      response = Net::HTTP.get_response(uri)
      {body: response.body, code: response.code.to_i}
    end
  end

end
  
