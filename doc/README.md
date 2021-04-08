# Documentação

## API

Para usar a api é necessário ter o insomnia com o plugin [uuSync](https://insomnia.rest/plugins/insomnia-plugin-uu-sync) instalado e importar o arquivo de rotas.

## Geração modelos

[Instalação RailsERD](https://voormedia.github.io/rails-erd/install.html)

O RailsERD se mostrou melhor para mostrar os relacionamentos corretamente,
para gerar o erd.pdf (renomear e jogar na pasta doc como doctour-erd.pdf), executar o comando:

```bash
rake erd
```

[Instalação RailRoady](https://github.com/preston/railroady)

Para gerar com RailRoady, executar o seguinte comando:

```bash
rake diagram:all
```

Anderson Souza - Indeorum@2021
