# Tea Tastes

Tea Tastes is a place to record impressions of teas. Features:
- Authenticated users can log in to create, edit, and delete tea notes.
- Notes can be linked to tea shops for another way to browse notes and for easy reordering.
- Unauthenticated users can view tea notes by tea, user, and tea shop.


## Installation

1. Clone this repo.
2. Install dependences:
```
    $ bundle install
```
2. Create database structure:
```
    $ rake db:migrate
```
3. Run web server:
```
    $ shotgun
```
4. Navigate to `localhost:9393` in your browser.


## Usage

<img src="/assets/Tea_Tastes-welcome.png" alt="Tea Tastes overview screen" />


Add your own data to get started. Or run the seed below to interact with a fully-populated app.
```
    $ rake db:seed
```

## Development

In addition to the web interface, you can interact with the app via command line by using `rake console`.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aparkening/tea_tastes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tea Taste project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aparkening/tea_tastes/blob/master/CODE_OF_CONDUCT.md).