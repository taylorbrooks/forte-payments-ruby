### A Ruby wrapper for the Forte Payments API

Learn about the Forte Payments REST API at https://www.forte.net/devdocs/api_resources/forte_api 

### Installation
Add this line to your application's Gemfile:
````ruby
  # in your Gemfile
  gem 'forte'

  # then...
  bundle install
````

### Usage
````ruby
  client = FortePayments::Client.new(
    api_key:     api_key,
    secure_key:  secure_key,
    account_id:  account_id,
    location_id: location_id
  )
````

### History

View the [changelog](https://github.com/taylorbrooks/forte-payments-ruby/blob/master/CHANGELOG.md)
This gem follows [Semantic Versioning](http://semver.org/)

### Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/taylorbrooks/forte-payments-ruby/issues)
- Fix bugs and [submit pull requests](https://github.com/taylorbrooks/forte-payments-ruby/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

### Copyright
Copyright (c) 2015 Taylor Brooks. See LICENSE for details.
