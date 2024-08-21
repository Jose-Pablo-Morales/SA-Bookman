# Use the official Ruby image as a base image
FROM ruby:3.3.4

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install the correct version of Bundler
RUN gem install bundler:2.5.11

# Set the working directory
WORKDIR /rails

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /rails/Gemfile
COPY Gemfile.lock /rails/Gemfile.lock

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY . /rails

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
