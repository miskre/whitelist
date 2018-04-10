bundle config build.libv8 --with-system-v8

case "$RAILS_ENV" in
  "development" )
    bundle install -j4;;
  "test" )
    bundle install -j4;;
  "production" )
    bundle install -j4 --without development test;;
esac
