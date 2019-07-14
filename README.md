# Brown-Field

This was a dive into inheriting a codebase that was poorly tested and organized. Some enhanchements:
- Test coverage went from ~60% to 99%
- Removed unnecessary routes and actions
- Fixed all broken CRUD functionalities
- Integrated VCR gem for all requests made in spec
- Added Github Omniauth
- Added User Friendships
- Added Mailers
  - Invite Email
  - User Activation Email

## Getting Started

You will need a github key and secret, as well as a youtube api key to run this locally. We used figaro to store all keys in application.yml


### Installing

Clone repo

```bash
$ brew install node
$ brew install yarn
$ yarn add stimulus
$ bundle install
```

### Data

```bash
$ bundle exec rake db:{create,migrate,seed}
```

## Running the tests

- Rspec/Capybara
- Shoulda-matchers

```bash
$ bundle exec rspec
```

## Built With

* [Rails](https://rubyonrails.org/)
* [Bundler](https://bundler.io/)
* [Yarn](https://yarnpkg.com/en/)

## Authors

* **Vince Carollo** - [VinceCarollo](https://github.com/vincecarollo)
* **Ryan Miller** - [RyanMillerGM](https://github.com/ryanmillergm)

## Production

* [Bloc Toque](https://bloc-toque-35099.herokuapp.com/)
