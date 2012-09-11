# Formatted Form

A Rails form builder that generates [Twitter Bootstrap](http://twitter.github.com/bootstrap) markup and helps keep your code clean.

* Uses existing Rails helpers
* Auto-generates labels
* Generates horizontal, vertical and inline forms
* Groups of checkboxes
* Groups of radio buttons
* Prevents double clicking on submit buttons

## Installation

Add gem definition to your Gemfile and run `bundle install`:
    
``` ruby
gem 'formatted_form'
```

Require it in your CSS and JS manifest files:

``` css
//= require formatted_form
```

## Configuration

You can change the default configuration of this gem by adding the following code to you initializers:

``` ruby
FormattedForm.configure do |conf|
  conf.default_form_class = 'form-vertical' # Set the form class. Default is 'form-horizontal'
end
```

## Usage (with haml)

Use `formatted_form_for` when you want to render a form with Bootstrap markup.

### A sample user form

``` ruby
= formatted_form_for [:admin, @user] do |f|
  = f.text_field :name
  = f.number_field :age, nil, :in => 1...100
  = f.email_field :email, :prepend => '@'
  = f.phone_field :phone
  = f.password_field :password
  = f.password_field :password_confirmation
  = f.select :role, User::ROLES
  = f.time_zone_select :time_zone
  = f.check_box :reminder, :label => 'Send Daily Reminder?'
  = f.submit 'Save'
```

### A login form

Add a class to the form or any field to change the way it is rendered.

``` ruby
= formatted_form_for @session_user, :url => login_path, :class => 'form-horizontal' do |f|
  = f.text_field :email
  = f.password_field :password
  = f.check_box :remember_me, :label => 'Remember me when I come back'
  = f.submit 'Log In'
```

### A search form

Hide the label by passing `:label => ''` on any field. (Useful for inline search forms)


``` ruby
= formatted_form_for @search, :url => [:admin, :users], :html => {:method => :get, :class => 'form-search'} do |f|
  = f.text_field :name_equals, :label => 'Find by', :placeholder => 'Name'
  = f.select :role_equals, User::ROLES, :label => ''
  = f.submit 'Search', :class => 'btn-default'
```

*(Example using [MetaSearch](https://github.com/ernie/meta_search) helpers)*

### Checkboxes

A single checkbox:

``` ruby
= f.check_box :send_reminder
```

A group of checkboxes:
  
``` ruby
= f.check_box :colours, :values => [['Red', 1], ['Green', 2], ['Blue', 3]]
```

Use the :help_block option to show the label on the right side:

``` ruby
= f.check_box :approved, :help_block => 'Label on the Right'
```


### Radio buttons

A single radio button:

``` ruby
= f.check_box :role, 'admin'
```

A group of radio buttons:

``` ruby
= f.radio_button :role, [['Admin', 1], ['Manager', 2], ['Editor', 3]]
```

### Submit
If you add 'formatted_builder' to your Javascript manifest you'll be able to add an extra `data-loading-text` option to submit buttons. This will prevent accidental multiple form submits.

``` ruby
= f.submit 'Log In', :data => {:loading_text => 'Saving ...'}
```

### More examples

Override the autogenerated label by using the `:label` option on any element.

``` ruby
= f.text_field :name, :label => 'Full name'
```

Use `:append` and `:prepend` on any field:

``` ruby
= f.text_field :price, :append => '.00'
= f.email_field :email, :prepend => '@'
```

Use `:help_block` to provide extra description to a fields:

``` ruby
= f.email_field :email, :help_block => 'Please enter your emails address'
```

---

Copyright 2012 Jack Neto, [The Working Group, Inc](http://www.theworkinggroup.ca)

