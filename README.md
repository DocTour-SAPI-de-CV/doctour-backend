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