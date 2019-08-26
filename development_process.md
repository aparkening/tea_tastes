# My Sinatra Project Development Process

## 1. Plan project, imagine interface

Tea Tastes is a place write down and share thoughts about teas. Features:
- Anyone can view tea tasting notes, teas, tea shops, and users.
- Authenticated users can create, edit, and delete their own tea notes, as well as any teas and shops.
- Notes are related to users and teas, and teas are related to shops, so it's easy to view all teas in a shop, all notes in a shop, all notes from a specific user, etc.
- Teas are browse-able by additional attributes, such as category, region, and country.

### Page Structure

- Home
- Sign up
- Log in
- User home
	- Edit user
- Display all notes
	- Create new note
		- Create new tea
			- Create new shop
	- Display note
	- Edit note
- Display all teas
	- Display tea
	- Edit tea
- Display all shops
	- Display shop
	- Edit shop

#### Main page (index.html)

- Summarize product: words and image(s) for what project is and why you'd use it
- Display login and signup links
- List of notes (latest first)

#### Sign Up and Log In

- Form 
	- Required username and password

#### User Home

- List of user-specific notes (latest first)

#### Edit User

- Pre-filled form
- Error and success messages

#### Create New Note

- Form with error messages
- New tea and new shop creation fields

#### Display Note

- Note content
- Success message upon creation
- Edit and delete links if note author

#### Edit Note

- Pre-filled form
- Error and success messages

#### Delete Note

- Only if note author

#### Display Tea

- Tea information, including description and attributes
- List of notes for tea
- Edit and delete links if authenticated user

#### Edit Tea

- Pre-filled form
- Error and success messages

#### Display Shop

- Profile information, including URL
- List of notes for teas from shop
- Edit and delete links if authenticated user

#### Edit Shop

- Pre-filled form
- Error and success messages


## 2. Outline project structure

### Model Structure

- User has many notes
- User has many teas through notes
- Tea belongs to shop
- Tea has many notes
- Tea has many users through notes
- Shop has many teas
- Shop has many notes through teas
- Note belongs to user
- Note belongs to tea

### File Structure

```
- app:
│   └── controllers:
│   │   └── application_controller.rb
│   │   └── notes_controller.rb
│   │   └── sessions_controller.rb
│   │   └── shops_controller.rb
│   │   └── teas_controller.rb
│   │   └── users_controller.rb
│   └── models:
│   │   └── note.rb
│   │   └── shop.rb
│   │   └── tea.rb
│   │   └── user.rb
│   │   └── concerns:
│   │   │   └── slugify.rb
│   └── views:
│   │   └── _errors.erb
│   │   └── _messages.erb
│   │   └── error.erb
│   │   └── index.erb
│   │   └── layout.erb
│   │   └── notes:
│   │   │   └── _note.erb
│   │   │   └── _teas_shops.erb
│   │   │   └── edit.erb
│   │   │   └── index.erb
│   │   │   └── new.erb
│   │   │   └── show.erb
│   │   └── shops:     
│   │   │   └── edit.erb
│   │   │   └── index.erb
│   │   │   └── show.erb
│   │   └── teas:    
│   │   │   └── _tea.erb 
│   │   │   └── edit.erb
│   │   │   └── index.erb
│   │   │   └── show.erb
│   │   └── users:
│   │   │   └── _user_links.erb
│   │   │   └── edit.erb
│   │   │   └── login.erb
│   │   │   └── new.erb
│   │   │   └── show.erb
- config:
│   └── environment.rb
- db:
│   └── development.sqlite 
│   └── migrate:
│   │   └── create_users
│   │   └── create_notes
│   │   └── create_shops
│   │   └── create_teas
│   └── schema.rb
│   └── seeds.rb
- public:
│   └── stylesheets:
│   │   └── bootstrap.min.css
│   │   └── styles.css
- spec:
- config.ru
- Gemfile
- Rakefile
- README.md
- development_process.md
```


## 3. Start with application controller interface

- Make configuration (views, sessions, etc.)
- Create base route(s) (index)
- Make helper methods


## 4. Code remaining routes and adjust models

1. Sessions 
2. Users
3. Notes
4. Shops
5. Record code-along screencast
6. [New] Add Tea model and adjust relationships


## 5. Write data and tests

1. Write seed data.
2. [Removed] Create Rspec tests.


## 6. Tweak program for user flow

- Update models to include Tea
- Sanitize user input
- Clarify navigation, links, and instructions
- Improve error handling and edge case responses

## 7. Improve styling and production quality

- Adjust frontend interface to be clear, responsive, and beautiful.
- Refactor backend code to consolidate methods and separate concerns
- Clean code for production


## 8. Update Readme and Code of Conduct

Model Readme on pattern in https://gist.github.com/PurpleBooth/109311bb0361f32d87a2.


## 9. Record demonstration w/ narration


## 10. Write blog post about process


## 11. Submit Flatiron checklist


## Stretch goals:

1. [Mostly Done] Make Responsive interface

2. Suggest new teas based on preferences. Scrape tea websites for suggestions table.
   #### Dobra
   1. 8 index pages: https://www.dobratea.com/
   - div#second-menu ul#menu-second-nav-header li (don't get accessories)
   - Get second page if not "showing all" results: https://www.dobratea.com/category/green/page/2/
   2. Detail pages: https://www.dobratea.com/product/assam-brahmaputra/

   #### Smith - https://www.smithtea.com/collections/all-tea?sort_by=title-ascending

3. Incorporate `tea_shopper` gem for tea shop scraping and object population. Add API to gem for non-CLI interaction.