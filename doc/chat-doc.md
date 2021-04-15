# Documentação do Chat

Para consultar a persistencia da comunicação, utilizaremos dois recursos o `ChatMessages` e o `ChatContacts`, ambos estão no padrão JSONAPI.
Para comunicação em tempo real (receber e enviar), é usada uma camada de websockets com ActionCable.

# JSONAPI

## ChatMessage

Permite a listagem das mensagens e a atualização para marcação de leitura.

### Rota

- index - GET /chat-messages
- show - GET /chat-message/id (acredito que não vai ser usada)
- update - PUT ou PATCH /chat-message/id

### Filtros:

- new - para trazer apenas novas mensagens recebidas (não lidas)

### Atributos:

- message (text)
- readed (bool)
- created_at (timestamp)
- updated_at (timestamp)

### Atributos atualizáveis:

- readed

### Relações

- to - ChatContact
- from - ChatContact

> \* podem ser incluidas com o parametro `include` da JSONAPI

## ChatContact

Permite a listagem dos contatos

### Rota

- index - GET /chat-contacts
- show - GET /chat-contacts/id (acredito que não vai ser usada)

### Atributos:

- email (text)
- name (text)
- category (text) - doctor, patient, assistant, etc...

# ActionCable

é usado para disparar e receber as mensagens em tempo real.

## ChatChannel

é necessário passar o token como parametro na URL.

### Actions

#### send_message

Tem a função de mandar e persistir a mensagem.

Parametros:

- to (string) - id do usuario
- message (text)

#### read_messages

Tem a função de setar todas as mensagens recebidas de determinado usuario como lidas.

Parametros:

- from (string) - id do usuario
