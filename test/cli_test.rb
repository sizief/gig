require "test_helper"

class CLITest < Minitest::Test
  
  def setup
    args = %w[topic:ruby topic:rails]
    @cli = ::Githubgrab::CLI.new args
  end

end