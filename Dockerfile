FROM ruby:3.3.4

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /product_api

# Copia el archivo Gemfile y Gemfile.lock
COPY Gemfile /product_api/Gemfile
COPY Gemfile.lock /product_api/Gemfile.lock

# Instala las gemas del bundle
RUN bundle install

# Copia el resto de la aplicación al contenedor
COPY . /product_api

# Expone el puerto en el que la aplicación se ejecutará
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["rails", "server", "-b", "0.0.0.0"]

