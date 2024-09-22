# Simulador de Lamport

Este é um simulador do Algoritmo de Lamport para relógios lógicos, desenvolvido em Flutter. O simulador permite a visualização do funcionamento do algoritmo e como os processos interagem entre si ao enviar mensagens.

## Recursos

- Adicionar processos com tempos incrementais.
- Simular eventos de comunicação entre processos.
- Visualizar a tabela de relógios dos processos.
- Destacar processos que recebem mensagens.

## Tecnologias Utilizadas

- Flutter
- Dart

## Pré-requisitos

Antes de executar o projeto, certifique-se de ter o seguinte instalado:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

## Como Executar o Projeto

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/simulador-lamport.git
   cd simulador-lamport
   code .
    ```

2. Instale as dependências
    ```bash
    flutter pub get
    ```

2.Execute o programa
    ``` bash
    flutter run
    ```


## Como Usar
1. Na seção "Configuração de Processos", insira o número de processos que deseja adicionar e clique em "Adicionar".
2. Na seção "Simulação de Evento", insira os IDs de origem e destino, juntamente com os tempos correspondentes.
4. Clique em "Simular Evento" para observar a atualização dos relógios dos processos.
4. A tabela exibirá os tempos de cada processo, e os processos que recebem mensagens serão destacados.


## Estrutura do Código
- lib/page/lamport.dart: Contém a lógica principal do simulador.
- lib/model/processo.dart: Define a classe Processo, que representa cada processo no simulador.


<p>
    <img 
      align=left 
      margin=10 
      width=80 
      src="https://avatars.githubusercontent.com/u/80135269?v=4"
    />
    <p>&nbsp&nbsp&nbspManuela Bertella Ossanes<br>
    &nbsp&nbsp&nbsp
    <a href="https://avatars.githubusercontent.com/u/80135269?v=4">
    GitHub</a>&nbsp;|&nbsp;
    <a href="https://www.linkedin.com/in/manuela-bertella-ossanes-690166204/">LinkedIn</a>
&nbsp;|&nbsp;
    <a href="https://www.instagram.com/manuossz/">
    Instagram</a>
&nbsp;|&nbsp;</p>
</p>
<br/><br/>
<p>