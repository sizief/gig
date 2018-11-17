require "test_helper"
require 'open-uri'


class GigTest < Minitest::Test
  def setup
    file = File.open("./test/data/api_response", "r") 
    @document = file.read
  end

  def test_that_it_has_a_version_number
    refute_nil ::Gig::VERSION
  end

  def test_extract_image_urls 
    images_array = Gig::Helper::extract_image_urls @document
    assert images_array.kind_of? Array
    assert_equal images_array[0], "https://avatars1.githubusercontent.com/u/4223?v=4" 
  end

  def test_remote_file_name
    WebMock.stub_request(:get, "https://avatars1.githubusercontent.com/u/4223?v=4").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Ruby'
    }).
    to_return(status: 200, body: "image", headers: {"Content-Type" => "image/png"})

    image_file = open("https://avatars1.githubusercontent.com/u/4223?v=4") 
    assert_equal Gig::Helper::remote_file_name(image_file), "4223?v=4.png"
  end
end
