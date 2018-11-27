require "test_helper"
require 'rest-client'

class GithubgrabTest < Minitest::Test
  def setup
    file = File.open("./test/data/api_response", "r") 
    @document = file.read
  end

  def test_that_it_has_a_version_number
    refute_nil ::Githubgrab::VERSION
  end

  def test_extract_image_urls 
    images_array = Githubgrab::Helper::extract_image_urls @document
    assert images_array.kind_of? Array
    assert_equal images_array[0], "https://avatars1.githubusercontent.com/u/4223?v=4" 
  end

  def test_remote_file_name
    WebMock.stub_request(:get, "https://avatars1.githubusercontent.com/u/4223?v=4").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip, deflate',
      'Host'=>'avatars1.githubusercontent.com',
      'User-Agent'=>'rest-client/2.0.2 (darwin18 x86_64) ruby/2.3.7p456'
      }).
    to_return(status: 200, body: "", headers: {"Content-Type"=>"image/png"})

    url = "https://avatars1.githubusercontent.com/u/4223?v=4"
    res = RestClient.get url
    assert Githubgrab::Helper::remote_file_name(url, res).include? "4223?v=4.png"
  end
end
