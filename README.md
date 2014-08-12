# Rails database yml

Generates multiple `config/database.yml` file with the environment information from your database service.

For this step you need to have a mysql or postgres. See the [services](http://devcenter.wercker.com/articles/services/) on wercker devcenter for more information about services.

## OPTIONS

- `service` This option is not required. If set, it will load the template from the specified service; otherwise, it will infer the service from the environment.
- `postgresql-min-message` (optinal, default: `warning`): Set the min_messages parameter in the postgresql template.
- `additional_databases`: Set the additinal database's prefix (ex. if you want to use `user_database.yml` and `recipe_database.yml`, specify `user,recipe`)

## EAMPLE

The following `wercker.yml`:

``` yaml
box: wercker/ruby
services:
  - wercker/postgresql
build:
  steps:
    - wantedly/rails-multiple-database-yml:
      additional_databases: user,recipe
```

Will generate the following `config/database.yml`:

``` yaml
test:
    adapter: postgresql
    encoding: "utf8"
    database: <%= ENV['WERCKER_POSTGRESQL_DATABASE'] %><%= ENV['TEST_ENV_NUMBER'] %>
    username: <%= ENV['WERCKER_POSTGRESQL_USERNAME'] %>
    password: <%= ENV['WERCKER_POSTGRESQL_PASSWORD'] %>
    host: <%= ENV['WERCKER_POSTGRESQL_HOST'] %>
    port: <%= ENV['WERCKER_POSTGRESQL_PORT'] %>
    min_messages: warning
```

`config/user_database.yml`:

``` yaml
test:
    adapter: postgresql
    encoding: "utf8"
    database: user_<%= ENV['WERCKER_POSTGRESQL_DATABASE'] %><%= ENV['TEST_ENV_NUMBER'] %>
    username: <%= ENV['WERCKER_POSTGRESQL_USERNAME'] %>
    password: <%= ENV['WERCKER_POSTGRESQL_PASSWORD'] %>
    host: <%= ENV['WERCKER_POSTGRESQL_HOST'] %>
    port: <%= ENV['WERCKER_POSTGRESQL_PORT'] %>
    min_messages: warning
```

`config/recipe_database.yml`:

``` yaml
test:
    adapter: postgresql
    encoding: "utf8"
    database: recipe_<%= ENV['WERCKER_POSTGRESQL_DATABASE'] %><%= ENV['TEST_ENV_NUMBER'] %>
    username: <%= ENV['WERCKER_POSTGRESQL_USERNAME'] %>
    password: <%= ENV['WERCKER_POSTGRESQL_PASSWORD'] %>
    host: <%= ENV['WERCKER_POSTGRESQL_HOST'] %>
    port: <%= ENV['WERCKER_POSTGRESQL_PORT'] %>
    min_messages: warning
```
