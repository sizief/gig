# Gig

This is a very simple CLI to get profile pictures of Github users. It uses the Github public API and for now it saves the first batch of response, first 30 images.  

  
## Installation
 
Add this line to your application's Gemfile:

```ruby
gem 'gig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gig

## Usage
 To get profile pictures of users who tagged `ruby`  
`bin/gig topic:ruby`  
and check the `topic:ruby` folder in the root.


Or finding topic `rails` and `ruby`

`bin/gig topic:ruby topic:rails`



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. 
To install this gem onto your local machine, run `bundle exec rake install`.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sizief/gig. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gig project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gig/blob/master/CODE_OF_CONDUCT.md).
