# My Sinatra Project Development Process

## 1. Plan project, imagine interface

Tea Tastes is a place to record impressions of teas. Features:
- Authenticated users can log in to create, edit, and delete tea notes.
- Notes can be linked to tea shops for another way to browse notes and for easy reordering.
- Unauthenticated users can view tea notes by tea, user, and tea shop.

### Page Structure

- All pages: user login and logout
- Main page
- Sign up
- Authenticated user home (user-specific list of notes)
- Create new note
	- Create new shop (included in post form)
- Display note
- Display user
- Display shop
- Edit note
- Edit user profile
- Edit shop
- Delete note
- Delete shop

#### Main page (index.html)

- Summarize product: words and image(s) for what project is and why you'd use it
- Display login form or logout link
- Display signup link

#### Sign Up

- Summarize signup benefits
- Form 
	- Required username and password
	- Optional additional fields

#### Authenticated User Home

- Link to add note
- List of user-specific notes
	- Can sort by date and tea name
- Short list of notes from others

#### Create New Note

- Form with error messages
- Form includes fields for tea shop name and URL

#### Display Note

- Note content
- Edit and delete links
- Success message upon creation
- Delete link

#### Display User

- Profile information
- List of user notes

#### Display Shop

- Profile information, including URL
- List of notes for teas from shop
- Delete link if authenticated user and no related notes

#### Edit Note

- Pre-filled form
- Delete link
- Error and success messages

#### Edit User Profile

- Pre-filled form
- Error and success messages

#### Edit Shop

- Pre-filled form
- Error and success messages

#### Delete Note

- Only if note author

#### Delete Shop

- Only if authenticated user and no related notes


## 2. Outline project structure

### Object Structure

- User has many notes
- Shop has and belongs to many notes
- Note belongs to user
- Note has and belongs to many shops

### File Structure

```
- app:
│   └── controllers:
│   │   └── application_controller.rb
│   │   └── notes_controller.rb
│   │   └── sessions_controller.rb
│   │   └── shops_controller.rb
│   │   └── users_controller.rb
│   └── models:
│   │   └── note.rb
│   │   └── shop.rb
│   │   └── user.rb
│   └── views:
│   │   └── index.erb
│   │   └── layout.erb
│   │   └── helpers:
│   │   │   └── index.erb
│   │   └── notes:
│   │   │   └── new.erb
│   │   │   └── edit.erb
│   │   │   └── show.erb
│   │   └── shops:     
│   │   │   └── edit.erb
│   │   │   └── show.erb
│   │   └── users:
│   │   │   └── index.erb
│   │   │   └── new.erb
│   │   │   └── edit.erb
│   │   │   └── show.erb
- config:
│   └── environment.r b
- db:
│   └── development.sqlite 
│   └── migrate:
│   └── seeds.rb
│   └── schema.rb
- public:
│   └── stylesheets:
│   │   └── styles.css
- rspec:
│   └── model_spec.rb
│   └── note_spec.rb
│   └── shop_spec.rb
│   └── user_spec.rb
- config.ru
- Gemfile
- Rakefile
- README.md
- PROCESS.md
```


## 3. Start with application controller interface


## 4. Stub remaining interface

1. Hardcode to show display details
2. Create Rspec tests
3. Replace each section with dynamic code.
	- Record code-along screencast


## 5. Run program and tweak

- Improve styling
- Improve error handling and edge case responses
- Refactor to consolidate duplicated work and separate concerns
- Clean up for production


## 6. Update Readme and Code of Conduct

Model Readme on pattern in https://gist.github.com/PurpleBooth/109311bb0361f32d87a2.


## 7. Record demonstration w/ narration


## 9. Write blog post about process


## 10. Submit Flatiron checklist


## Stretch goals:

1. Make Responsive interface

2. Suggest new teas based on preferences. Scrape tea websites for suggestions table.
   #### Dobra
   1. 8 index pages: https://www.dobratea.com/
   - div#second-menu ul#menu-second-nav-header li (don't get accessories)
   - Get second page if not "showing all" results: https://www.dobratea.com/category/green/page/2/
   2. Detail pages: https://www.dobratea.com/product/assam-brahmaputra/

   #### Smith - https://www.smithtea.com/collections/all-tea?sort_by=title-ascending

3. Incorporate `tea_shopper` gem for tea shop scraping and object population. Add API to gem for non-CLI interaction.