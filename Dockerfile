FROM ruby:2.5.0

# Install postgres library
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set working path
ENV APP_PATH /app
WORKDIR $APP_PATH

# Add Gemfile to the image
ADD Gemfile* ./

# Install dependencies
RUN bundle install

EXPOSE 3000

# Default command start the rails server on port "3000"
CMD ["rails", "server", "--port", "3000", "--binding", "0.0.0.0"]
