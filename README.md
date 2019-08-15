# Tea Tastes

Tea Tastes is a place to record impressions of teas. Features:

- Anyone can view tea tasting notes, teas, tea shops, and users.
- Authenticated users can create, edit, and delete their own tea notes, as well as any teas and shops.
- Notes are related to users and teas, and teas are related to shops, so it's easy to view all teas in a shop, all notes in a shop, all teas from a specific user, etc.
- Teas are browseable by additional attributes, such as category, region, and country.

<img src="/public/assets/tea-tastes-screenshot.png" alt="Tea Tastes welcome screen" />

## Installation

1. Clone this repo.
2. Install dependences:
```
    $ bundle install
```
3. Create database structure:
```
    $ rake db:migrate
```
4. Run web server:
```
    $ shotgun
```
5. Navigate to `localhost:9393` in your browser.

## Usage

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

Everyone interacting in the Tea Tastes project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aparkening/tea_tastes/blob/master/CODE_OF_CONDUCT.md).