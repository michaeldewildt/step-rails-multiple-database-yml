template_name=""

if [ -z $WERCKER_RAILS_MULTIPLE_DATABASE_YML_POSTGRESQL_MIN_MESSAGE ]; then
  export WERCKER_RAILS_MULTIPLE_DATABASE_YML_POSTGRESQL_MIN_MESSAGE="warning"
fi

if [ ! -n "$WERCKER_RAILS_MULTIPLE_DATABASE_YML_SERVICE" ]; then
  debug 'service option not specified, looking for services in the environment'

  if [ -n "$WERCKER_MYSQL_HOST" ]; then
    info 'mysql service found'
    template_name="mysql"
  elif [ -n "$WERCKER_POSTGRESQL_HOST" ]; then
    info 'postgresql service found'


    template_name="postgresql"
  else
    fail 'No compatible service defined in wercker.yml.\nSupported service are: mysql and postgresql.\n\nSee: http://devcenter.wercker.com/articles/services/'
  fi
else
  debug 'service option specified, will load specified template'
  template_name="$WERCKER_RAILS_MULTIPLE_DATABASE_YML_SERVICE"
fi

info "using template $template_name"
template_filename="$WERCKER_STEP_ROOT/templates/$template_name.yml"

if [ ! -f "$template_filename" ]; then
  fail "no template found with name $template_name"
else
  config_filename="$PWD/config/database.yml"

  if [ -f "$config_filename" ]; then
    warn 'config/database.yml already exists and will be overwritten'
  fi

  # cp -f "$template_filename" "$config_filename"
  sed \
    -e "s;\$WERCKER_RAILS_MULTIPLE_DATABASE_YML_POSTGRESQL_MIN_MESSAGE;$WERCKER_RAILS_MULTIPLE_DATABASE_YML_POSTGRESQL_MIN_MESSAGE;g" \
    "$template_filename" > "$config_filename";

  info "created database.yml in config directory with content:"
  info "$(cat "$config_filename")"
fi
