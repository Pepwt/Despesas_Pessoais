# expenses

Despesas Pessoais
Este é um aplicativo de controle de despesas pessoais desenvolvido em Flutter. Ele permite registrar transações financeiras e visualizar estatísticas por meio de gráficos.

## Funcionalidades Principais

1. Adicionar Transações: É possível adicionar novas transações com título, valor e data.

2. Visualizar Lista de Transações: A tela inicial exibe a lista de transações recentes. Caso não haja transações cadastradas, é mostrada uma mensagem indicando que não há transações.

3. Visualizar Gráfico de Despesas: Há uma opção para visualizar um gráfico de barras representando as despesas dos últimos 7 dias. Cada barra no gráfico representa o total das despesas em um dia específico da semana.

## Capturas de Tela

Capturas de Tela


Tela Inicial
![Tela Nenhuma Transação](assets/images/ntransacao.png)
A tela exibida quando não há transações cadastradas.


Tela de Transação
![Tela de Transação](assets/images/telatransacao.png)
A tela de transação permite adicionar uma nova transação inserindo o título, o valor e selecionando a data da transação. Após preencher os campos, o usuário pode clicar no botão "Nova Transação" para confirmar a adição.


Adicionar Transação
![Tela Adicionar Transação](assets/images/transacao.png)
Formulário para adicionar nova transação.


Gráfico
![Tela Gráfico](assets/images/grafico.png)
A tela do gráfico exibe um gráfico de barras representando as despesas dos últimos 7 dias. Cada barra no gráfico representa o total das despesas em um dia específico da semana.No canto superior direito, há um ícone de "menu" para acessar a lista de transações.


## Como Executar

Para executar o projeto em seu ambiente local, siga as etapas abaixo:

1. Certifique-se de ter o Flutter instalado em sua máquina. Você pode verificar executando o comando `flutter --version` no terminal.
2. Clone este repositório para o seu ambiente local.
3. Abra o diretório do projeto no terminal.
4. Execute o comando `flutter pub get` para instalar as dependências do projeto.
5. Execute o comando `flutter run` para iniciar o aplicativo no dispositivo/emulador conectado.

## Pacotes Utilizados

1. intl: Para formatação de datas e valores monetários.
2. flutter_png: Para renderizar imagens PNG.
3. charts_flutter: Para criar gráficos de barras.
4. cupertino_icons: Para adicionar ícones específicos do iOS.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir novas issues ou pull requests para melhorias no código.

## Autor

Este aplicativo foi desenvolvido por Pedro Antônio como parte do aprendizado em Flutter.


