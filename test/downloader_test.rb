require "test_helper"
require 'open-uri'


class DownloaderTest < Minitest::Test
  
  def setup
    @destination = %w[test-folder topic:ruby topic:rails].join("-")
    @image_array = File.readlines("./test/data/image_list")
    @downloader = Gig::Downloader.new @image_array,  @destination
  end

  def test_create_folder
    @downloader.send :create_folder
    assert File.directory? @destination
  end

  def test_save 
    image = @image_array.first
    WebMock.stub_request(:get, "https://avatars1.githubusercontent.com/u/4223?v=4").
    with(
    headers: {
	  'Accept'=>'*/*',
	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
	  'User-Agent'=>'Ruby'
    }).
    to_return(status: 200, body: "", headers: {"Content-Type" => "image/png"})

    @downloader.send :save, image
    assert File.exist?("#{@destination}/4223?v=4.png")
  end

end