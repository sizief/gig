require 'rest-client'

module Gig
  
  class Gateway
    
    def self.call args
      begin 
        response = RestClient.get "https://api.github.com/search/repositories?q=#{args.join('+')}"
        {body: response.body, code: response.code.to_i}
      rescue RestClient::ExceptionWithResponse => e
        {body:  e.response, code: 1000}
      rescue SocketError
        {body:  'Network connectivity issue, please check your network', code: 1001} 
      end
    end

  end

end
  
#TODO: use response.headers[:link].split(",").first.split(";").first[/<(.*)>/,1] to get next link 
#and add remaining links to response hash. 
 