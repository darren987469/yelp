# Yelp like website

Feature: Let users can query the opening restaurants according to the time they will go.

# How to handle this problem?

## Step1 Define the API/Request Spec

Analysis the requirement and extract input and output. According to the feature description and sample data, the input params are weekday and time; output response are restaurants.

I limit the time options to fixed options such as '00:00', '00:30'... to simplify input. This may not be the case of the real world.

```javascript
// API spec, GET /restaurants
// request params
{
  weekday: 'string', // mon, tue, wed, thu, fri, sat, sun
  time: 'string' // 00:00, 00:30, 01:00, 01:30 ...
}

// response
[
  { name: 'string' },
  ...
]
```

## Step2 design database schema

In this step, I ask myself some questions: How to store the data? What schema design can let the query more easy or more efficiency? This problem is common, is there any existing solutions? Maybe there is already a gem to handle this, what is it's design?

After check the sample data, I found that cross day open hours need to be taken into consideration. For example, restaurant may open from mon 17:30 to tue 10:30. I searched for how others modeling and handling this problem, and also whether there is any existing solutions.

After searching, I found there is a similar schema design but there is a little different. They model the open hours column `open_at` and `close_at` in type time. The `open_at` in sample data is a String. I am not familiar with the type time, and I am curious about what will happen if I compare two string time, such as `'00:00' > '00:30' ?`. So I tried in the postgres and it works!

```SQL
SELECT '00:00' < '00:30'
# => true
SELECT '00:00' > '00:30'
# => false
```

There maybe other data type suitable for this question. But I set the goal: 2 hours to finish the challenge. Since it works, I decide to define column `open_at` and `close_at` in type string. I mode the cross day open hours data as

```javascript
{ weekday: :mon, open_at: '00:00', close_at: '10:30' },
{ weekday: :mon, open_at: '17:30', close_at: '24:00' },
{ weekday: :tue, open_at: '00:00', close_at: '10:30' }
```

The schema are something like
```SQL
CREATE TABLE 'restaurants' (
  'name' string
)
CREATE TABLE 'open_hours' (
  'restaurant_id' integer,
  'weekday' integer,
  'open_at' string,
  'close_at' string
)
```

So when I query with weekday :tue and time '01:00', the query will be
 ```sql
 SELECT *
 FROM restaurants
 JOIN open_hours
 WHERE open_hours.weekday = :tue AND '01:00' >= open_hours.open_at AND '01:00' < open_hours.close_at
 ```

Note that I use `time >= open_at` and `time < close_at` in the query. The edge case need to be taken into consideration. It is reasonable to say restaurant is opening when time qual `open_at` but not the case when the time equal to `close_at`.

### Step3 Seed data

I wrote a script in `seed.rb` to transfer sample data and store it in database. The script is idempotent. It fake the same data in database no matter how many times you execute it. I wrote a work around method to import cross day open restaurant data. I haven't come up with a general solution to the type of data, So I leave the `FIXME` comment to remind for future fixing.

### Step4 Implement feature

Add controller, views, routes. There maybe something missed in former step. I go back to former step and make it more complete. The better flow is that when user change an option, web makes a ajax call to get opening restaurants. I decide to use form submit and render the page again for easier development. I assume the request params is all valid so I didn't do params validation. This is not the case when developing API.

### Conclusion

It takes me about 3 hours to finish the feature. Including clarify the requirement, understand the sample data, survey possible solutions, design database schema, seed data and implement feature. There are many things can improve, such as better schema design, query optimization, user experience etc. But I stop optimizing and use the workable solution to develop as soon as possible.

# How to run it?

Prerequisites

* Install ruby 2.5.0, bundler gem and postgresql

Install

```sh
bundle install # install dependencies
rails db:setup # create db and seed it
rails s        # start the server
```

Go [localhost:3000](http://localhost:3000)

![Demo](https://github.com/darren987469/yelp/blob/master/gifs/demo.gif)

## Testing

```sh
rspec
```
