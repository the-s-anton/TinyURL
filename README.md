This is a simple Url shortener application.

## Setup
Ruby - `v3.2.2`

Ruby on Rails - `v7`

Ensure that all necessary ruby gems are installed.

```ruby
bundle install
```

Run database migrations

```ruby
rails db:create db:migrate db:seed
```

## Running the app
I decided to add some Tailwindcss. Therefore we will need to run the server via `Procfile`

```ruby
bin/dev
```


## Testing
I use `Rspec` for testing; run `rspec` in your terminal to run tests.

```ruby
rspec
```

-----

This app has two different setups:

1. First setup uses the whole stats collection. To use the basic approach, go to the `urls_controller.rb#redirect` and update the code to the following:

```ruby
redirect_url.clicks.create(ip_address: request.remote_ip)
# publish_event(Url::Clicked, id: redirect_url.id, ip_address: request.remote_ip)
```

2. Second setup uses a pub-sub implementation and assumes that our TineURL app is top-rated. That's why the logic was moved to the `background`. The other reason for using PubSub here is to make all models very isolated from each other. It will help us to keep our code clean and avoid coupling.

PubSus setup can be found in the `app/lib` folder; please note I didn't write a spec for the PubSub.

-----

## What's next?

Add a state machine to make our Event, Operation, and EvenHandler consistent. https://github.com/gocardless/statesman - perfect database-driven state machine that will work just right for our setup.

`Operation` files or `EventHandler` will be in charge of moving between the states where our states are `statuses` or, in other words, `enum` values.

```ruby
self.class.state_machine.transition_to!(:new_state_here)
```
