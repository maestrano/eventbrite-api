eventbrite-api
===============

[![Build Status](https://secure.travis-ci.org/BrunoChauvet/eventbrite-api.png?branch=master)](http://travis-ci.org/BrunoChauvet/eventbrite-api)

## Eventbrite API client

Integrate with ![Eventbrite API](http://developer.eventbrite.com/)

## Installation

Add this line to your application's Gemfile:

`gem 'eventbrite-api'`

And then execute:

`bundle`

Or install it yourself as:

`gem install eventbrite-api`

## Usage

### OAuth Authentication

If you've already got an OAuth access token, feel free to skip to API Client Setup.

The Eventbrite API uses 3 legged OAuth2. You need to implement the following controller methods and store the `access_token` if needed.


``` ruby
    class EventbriteSessionController  
      def new
        redirect_to eventbrite_client.get_access_code_url
      end

      def create
        @token = eventbrite_client.get_access_token(params[:code])
      end

      def eventbrite_client
        @api_client = Eventbrite::Api::Client.new({
          consumer: {
            key:    YOUR_CONSUMER_KEY,
            secret: YOUR_CONSUMER_SECRET,
          },
          redirect_uri: callback_create_url
        })
      end
    end
```

### API Client Setup

#### Create an api_client

``` ruby
    api_client = Eventbrite::Api::Client.new({
      consumer: {
        key:    YOUR_CONSUMER_KEY,
        secret: YOUR_CONSUMER_SECRET,
      },
      access_token: YOUR_OAUTH_ACCESS_TOKEN
    })
```

### API Methods

#### get

Retrieves the first page of specified collection

```ruby
  categories = api_client.category.get
```

#### next_page / previous_page

Retrieves the next/previous page of specified collection. A call to `get` must have been performed first

```ruby
  categories = api_client.category.get
  next_categories = api_client.category.next_page
  previous_categories = api_client.category.previous_page
```

#### find

Retrieves a single element by uid

```ruby
  event = api_client.event.find('123')
```

#### create

Creates a resource

```ruby
  event = api_client.event.create({'name' => 'My Event', ...})
```

#### update

Updates a resource

```ruby
  event = api_client.event.update('123', {'name' => 'My Event', ...})
```

#### all

Fetches the entire collection of elements

```ruby
  categories = api_client.category.all_items
```

### API Resources

#### Events

Search events
```ruby
  events = api_client.event.search
  more_events = api_client.event.next_page

  filtered_events = api_client.event.search({params: {q: 'sandwich'}})
```

Create event
```ruby
  event = api_client.event.create({'name' => 'My Event', ...})
```

Publish/Unpublish events
```ruby
  response = api_client.event.publish('13270934723')
  response = api_client.event.unpublish('13270934723')
```

#### Event ticket class

Create an event ticket class for event '123'
```ruby
  event = api_client.event_ticket_class.create({'name' => 'My Ticket', ...}, {event_id: '123'})
```

Update event ticket class '456' for event '123'
```ruby
  event = api_client.event_ticket_class.update('456', {'name' => 'My Ticket', ...}, {event_id: '123'})
```

#### Owned Events

User owned events
```ruby
  events = api_client.owned_event.get({'user_id'=>'133925426255'})
```

#### Owned Event Attendees

User owned event attendees
```ruby
  event_attendees = api_client.owned_event_attendee.get({'user_id'=>'133925426255'})
```

#### Owned Event Orders

User owned event orders
```ruby
  event_orders = api_client.owned_event_order.get({'user_id'=>'133925426255'})
```

#### Categories

```ruby
  categories = api_client.category.get
```

#### Formats

```ruby
  formats = api_client.format.get
```
