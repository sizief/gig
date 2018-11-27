require "test_helper"

class DownloaderTest < Minitest::Test
  
  def setup
    @destination = "./test/tmp/" + %w[topic:ruby topic:rails].join("-")
    @image_array = File.readlines("./test/data/image_list")
    @downloader = Githubgrab::Downloader.new @image_array,  @destination
  end

  def test_create_folder
    @downloader.send :create_folder
    assert File.directory? @destination
  end

  def test_save 
    @downloader.send :create_folder
    url = "https://avatars1.githubusercontent.com/u/4223?v=4"
    image = @image_array.first
    WebMock.stub_request(:get, url).
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip, deflate',
      'Host'=>'avatars1.githubusercontent.com',
      'User-Agent'=>'rest-client/2.0.2 (darwin18 x86_64) ruby/2.3.7p456'
      }).
    to_return(status: 200, body: "", headers: {"Content-Type" => "image/png"})

    @downloader.send :save, image
    assert Dir["#{@destination}/*-4223?v=4*"].any?, "image is not saved"

    # test for image exists method, because we need at least one file in the directory, this test insrted here
    is_exists = @downloader.send :image_exists, "https://avatars1.githubusercontent.com/u/4223?v=4"
    assert is_exists, "can not found file"
  end
end