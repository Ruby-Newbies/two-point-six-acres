# Two-Point-Six-Acres

A Forum Specially Designed for Foreign Students in the U.S.

## Collaborators

| Name         | UNI    |
| ------------ | ------ |
| Tianyou Song | ts3347 |
| Wenye Ma     | wm2454 |
| Xiaofan Wang | xw2741 |
| Yifan Zhang  | yz3959 |

## Development

Github: https://github.com/Ruby-Newbies/two-point-six-acres



## How to Start

Install gems:
```shell
bundle install  
# If there is any update
# Use bundle update
```

Data migration:
```shell
bundle exe rake db:migrate
```

Add seeds data:
```shell
bundle exe rake db:seed
```

Check routes:
```shell
bundle exe rake routes
```

Start the server:
```shell
bundle exe rails s
```

Check API using curl:
```shell
curl -i http://localhost:3000/api/v1/articles/1.json
# You have to add .json postfix
```

## Test

### Cucumber

Before running cucumber tests, run the following command to clear the seed data from the database,
otherwise the background step of articles.feature would fail:
```shell
rake db:reset
```

Run all cucumber tests:
```shell
rake cucumber
```

### RSpec

Before running rspec tests, run the following command to populate the test database with seed data:
```shell
rake db:seed RAILS_ENV=test
```

Run all rspec tests:
```shell
rake spec
```

## Deployment

Heroku Link: 