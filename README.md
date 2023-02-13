# DocTour - Backend
Backend of the DocTour project

## Passos para rodar o projeto:
### 1º Passo:
`docker-compose build`

### 2º Passo:
`docker-compose run --rm server bash`
`bundle exec rake db:drop db:create db:migrate`
`bundle exec rails db:migrate populate:setup accounts:setup`

## Emails
Acessar: `http://localhost:3000/rails/mailers`

## Deploy Heroku
`heroku login`
Configurar o remote
`git push heroku master`


### Comandos úteis
`bundle exec rake db:migrate`

#### This command will list all table in a rails app in rails console
`ActiveRecord::Base.connection.tables`