# DigioProducts

Este é um projeto de exemplo para iOS usando Swift 4.2. O objetivo é demonstrar o uso de SwiftLint, URLSession + Codable, testes unitários, e a documentação básica.

## Requisitos

- Xcode 12 ou superior
- iOS 12 ou superior

## Instalação

1. Clone o repositório:
    ```bash
    git clone https://github.com/seu-usuario/app-teste.git
    ```

2. Navegue para o diretório do projeto:
    ```bash
    cd DigioProducts
    ```

3. Abra o projeto no Xcode:
    ```bash
    open DigioProducts.xcodeproj
    ```


## Configuração

### SwiftLint

SwiftLint é utilizado para garantir que o código siga as convenções de estilo do Swift. Para verificar e corrigir problemas de lint, execute o seguinte comando:

```bash
swiftlint
```

### URLSession + Codable

A camada de rede do projeto usa `URLSession` e `Codable` para fazer requisições e processar respostas. Certifique-se de que a camada de rede esteja configurada corretamente e que todos os endpoints estejam funcionando conforme esperado.

## Executando o Projeto

1. Selecione o esquema desejado no Xcode.
2. Clique no botão "Run" ou use o atalho `Cmd + R` para compilar e executar o aplicativo no simulador ou dispositivo conectado.

## Testes

Para executar os testes, selecione o esquema "AppTesteTests" e clique no botão "Test" ou use o atalho `Cmd + U`.

## Explicações

### Estrutura do Projeto

- **NetworkService**: Classe responsável pela comunicação com a API. Implementa métodos para realizar requisições e processar as respostas, utilizando `URLSession` e `Codable`.
  
- **Models**: Contém as definições de modelos de dados, como `Store`, `Spotlight`, `Product` e `Cash`. Estes modelos são usados para mapear as respostas da API para objetos Swift.

- **SwiftLint**: Ferramenta de linting para garantir que o código siga as melhores práticas e convenções de estilo do Swift. As regras podem ser configuradas no arquivo `.swiftlint.yml`.

### Configuração de Requisições

A camada de rede está configurada para suportar diferentes tipos de requisições HTTP, como GET, POST, DELETE e UPDATE. As URLs devem ser completas, e os parâmetros devem ser passados conforme necessário.

### Testes Unitários

Os testes unitários verificam a funcionalidade da aplicação e a integridade do código. Eles são uma parte essencial do processo de desenvolvimento para garantir que o aplicativo funcione conforme o esperado.

### Padrão MVVM

O projeto utiliza o padrão MVVM (Model-View-ViewModel) para separar as responsabilidades e facilitar a manutenção e testabilidade do código:

- **Model**: Representa os dados da aplicação e a lógica de negócios. Neste projeto, são representados pelas estruturas `Store`, `Spotlight`, `Product` e `Cash`.

- **View**: É responsável pela interface do usuário. Recebe as informações do ViewModel e apresenta-as ao usuário. A view deve ser o mais simples possível e apenas exibir dados, sem lógica de negócios.

- **ViewModel**: Faz a mediação entre a View e o Model. Processa a lógica de apresentação e manipula os dados do Model antes de enviá-los para a View. Permite que a View se mantenha desacoplada da lógica de negócios e facilita os testes unitários.

O padrão MVVM ajuda a criar um código mais modular e organizado, permitindo que a lógica de negócios e a lógica de apresentação sejam testadas e desenvolvidas de forma independente.

### Modular Table

O projeto utiliza uma extensão da `UITableView` chamada Modular Table, que facilita a criação de telas de maneira mais rápida e prática. Essa extensão permite:

- **Construção**: Para cada `CellView` (`UITableViewCell`), um `CellController` é criado. Isso permite uma configuração e reutilização mais eficientes das células.
  
- **Configurabilidade**: Os `CellControllers` são altamente configuráveis, permitindo ajustes específicos para cada célula sem a necessidade de modificar diretamente a `UITableView`.

- **Reutilização**: Com a Modular Table, é possível reutilizar células e controllers em diferentes partes da aplicação, reduzindo a duplicação de código e melhorando a manutenção.

Esse padrão ajuda a manter a `UITableView` organizada e a facilitar a implementação de telas complexas com múltiplas células, promovendo um código mais limpo e gerenciável.

## Aviso

Peço desculpas pela falta de polimento neste projeto. Devido a uma viagem, não terei tempo para melhorar os detalhes neste momento. Agradeço pela compreensão.

