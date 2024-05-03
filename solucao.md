# Funcionalidades Apresentadas Para o Desafio Globo
O presente documento tem o intuito de orientar os avaliadores a respeito da mentalidade empreendida para a resolução do desafio proposto.
## 👤 Integrante
- Ermeson José Ribeiro
  ( [github](https://github.com/Ermeson23) | [linkedin](https://linkedin.com/in/ermeson-ribeiro-a29121212/) )

## 📄 Descrição
O presente documento tem o intuito de orientar os avaliadores a respeito das ideias e da mentalidade empreendida para a resolução do desafio proposto.

## 🖇️ Visão Geral das Especificações 
### 🖥️ Aplicativo 
Além da criação de uma nova Organização como solicitado, foi criado o aplicativo Desafio Globo a fim de centralizar os requisitos do projeto e falicitar a identificação e o acesso aos mesmos pelos responsáveis pela avaliação da solução. Este aplicativo Ligthining customizado possui as seguintes guias:

- Início
- Contas
- Ordens
- Países

Dentre as características existentes, compreendo que as guias possibilitam a visualização e o acesso rápido e intuitivo aos registros dos respectivos objetos(padrões e personalizados).

## 🖼️ Objetos utilizados
### 🖼️ Objetos Personalizados
- Ordem
- País

### 🖼️ Objetos Padrão
- Contas

## ✨ Campos Customizados

### Objeto Ordem
Para o objeto customizado Ordem foram criados os seguintes campos customizados:
- E-mail
- Id da Ordem
- Valor da Ordem
- Nome da Conta

- O campo "Id da Ordem" é uma informação única e autogerada, para garantir que cada uma ordem é única. 
- O campo "Valor da Ordem", por sua vez, é um valor do tipo de dado Moeda, tendo em vista que com ele são realizadas operações aritméticas.
- O campo "Nome da Conta" diz respeito a um campo especial, definido por um Relacionamento do tipo Mestre e Detalhes. Foi escolhido o relacionamento entre mestre e detalhes para Conta e Ordem pois não faz sentido uma ordem existir se ela não for atribuída a um pagador("mestre"), portanto ela deve ter um responsável para ser registrada, ou seja, a existência de uma ordem é condicionada uma conta; por outro lado, uma conta pode ter zero ou n-ésimas ordens relacionadas a ela. Em suma, existe uma forte dependência entre o objeto Mestre(Conta) e o objeto Detalhes(Ordem), o objeto Ordem não existe sem estar associado a um objeto Conta.

### Objeto País
Para o objeto customizado País foram criados os seguintes campos customizados:
- Sigla
- Moeda
- Idioma

Todos eles pertencentes ao tipo de dados texto. Pareceu conveniente escolher este tipo de dado (texto) pois não havia nenhuma operação aritmética relacionado ao campo personalizado "Moeda", que embora seja chamado "Moeda" ele possui o tipo de dado texto. Portanto não houve problema em declará-lo como texto (string). O campo Sigla é assinalado como obrigatório, além de ser único. Logo, não podem existir dois registros de países com a mesma sigla. Na minha solução não assinalei para o campo diferenciar letras minúsculas de maiúsculas, então os valores "BR" e "br" são considerados idênticos.

### Objeto Conta
Embora tenha sido utilizado o objeto padrão Conta foram criados alguns campos customizados para a implementação da solução:
- Valor total de Vendas
- País
- Informações do País

O Valor total de Vendas é um campo do tipo Moeda, além de, neste caso, ser exclusivamente de leitura, isto é, o usuário não consegue alterar diretamente este valor. Ele é incrementado com o somatório dos valores das Ordens relacionadas a ele, porém lido melhor com isto na etapa de automação.

Para o campo País, por sua vez, efetuei um relacionamento de Pesquisa entre Conta e País. Tendo em vista que a existência de um país não está condicionada a uma conta, pois ele é independente, utilizei apenas um relacionamento de pesquisa entre os objetos ora citados.

Para reunir as Informações do País, utilizei um campo de fórmula com o tipo de dado texto, onde pude agregar a este campo os dados concernentes ao Nome, Sigla, Idioma e Moeda. Caso alguma das informações não obrigatórias não fossem fornecidas ao registro de um País, foi atribuído o valor "N/A". Uma ligeira observação é que o campo por nome de Moeda não poderia receber "N/A" se ele tivesse sido definido como tipo de dado moeda anteriormente.

## ✨ EndPoints Customizados
### UpSert de uma Conta

Para a implementação do EndPoint customizado UpSert no objeto Conta, criei a uma classe chamada UpsertAccountEndPoint, utilizando os recursos de API REST para fazer requisições HTTP. Como foi solicitada um UpSert, utilizei o método @HttpPut a fim de permitir a criação de novos registros e a atualização de registros existentes. Para possibilitar também a inserção e a atualização de registros em massa, utilizei uma lista para armazenar os registros a serem inseridos ou atualizados.

- Para inserir registros o contrato mínimo de entrada precisa ser:
    [ 
        {
            "Name": "DBC Company Together",
            "Email__c": "dbccompany@gmail.com",
            "Country__c": "a00bm000003tdimAAA",
        }
    ]

- Para atualizar registros no objeto Conta o contrato mínimo de entrada precisa ser:
    [ 
        {
            "Name": "DBC Company Together",
            "Email__c": "dbccompany@gmail.com",
            "Country__c": "a00bm000003tdimAAA",
            "Account_ID__c": "00049"
        }
    ]

- Para o contrato de saída eu optei por uma opção simplória, também adaptada ao escopo do projeto e ao tempo de entrega:
    - Na execução com sucesso: Retorna-se uma mensagem informando que a inserção/atualização aconteceu com sucesso e o conteúdo do registro.
    - Na execução com falha: Retorna-se uma mensagem de erro, capturada pelo catch, informando a presença do erro assim como a explicação daquilo que o ocasionou.

    Em ambos os casos o retorno(ou a ausência de retorno) é void.

Obs 1: Para a atualização de um registro Conta é necessário informar o identificador(um número único e autogerado) do registro a ser modificado.
Obs 2: Com contrato mínimo me refiro às informações obrigatórias para a inserção/edição de um registro do tipo Conta.
Obs 3: É perceptível que estou utilizando um identificador estático para um país, isto por conta do tempo também, mas segundo as boas práticas esta informação precisa ser dinâmica, inserida pelo usuário.

### Insert de uma Ordem

Para a implementação do EndPoint customizado Insert no objeto Ordem, criei a uma classe InsertOrderEndPoint, utilizando os recursos de API REST para fazer requisições HTTP. Como foi solicitada um Insert, utilizei o método @HttpPost a fim de permitir a criação de novos registros. Para oferecer inserção registros em massa, utilizei uma lista para armazená-los e depois inseri-los.

- Para inserir registros no objeto Ordem o contrato mínimo de entrada precisa ser:
    [ 
        {
            "Name": "Ordem C",
            "Email__c": "ordemC@gmail.com",
            "Order_Value__c": 18000,
            "AccountName__c": "001bm000007hwZxAAI"
        }
    ]

- Como informado acima, para o contrato de saída optei por um recurso simplório, também adaptada ao escopo do projeto e ao tempo de entrega:
    - Na execução com sucesso: Retorna-se uma mensagem informando que a inserção do registro ordem ocorreu com sucesso e acompanhada da exibição do conteúdo do registro.
    - Na execução com falha: Retorna-se uma mensagem de erro, capturada pelo catch, informando a presença do erro, assim como a explicação daquilo que o ocasionou.

    Em ambos os casos o retorno(ou a ausência de retorno) é void.

Obs 1: Com contrato mínimo me refiro às informações obrigatórias para a inserção de um registro do tipo Ordem.
Obs 2: É perceptível que estou utilizando um identificador estático para uma conta, o tempo e o escopo do projeto são fatores relevantes a isto, mas segundo as boas práticas esta informação precisa ser dinâmica, de acordo com a interação do usuário.

## 🖇️ Automações
### Enviar um Email Sempre que uma Conta é Criada ou Editada
Como esta automação deveria ser realizada com código, implementei uma classe para envio de um e-mail chamada "AccountHandlerClass" e uma trigger(gatilho) chamada de "SendAnEmailOnCreateOrEditAccount" para que fosse acionada sempre que, sendo respeitadas certas condições pré-estabelecidas na classe supracitada, ocorresse a criação ou edição de uma nova conta. A classe exige que o e-mail do usuário não seja nulo e de que uma caixa de texto com o nome enviar e-mail esteja assinalada. Assim, um e-mail definido na própria classe é enviada para o usuário. Nesta ocasião, eu optei por definir os elementos padrões do email na própria classe, embora eu conheça a existência dos modelos de e-mail oferecidos pela Salesforce. No que tange à interface gráfica, a fim de implementar uma solução simples e direta, incluí os campos personalizados de e-mail, e uma caixa de seleção para o envio do e-mail, no próprio formulário padrão de preenchimento de uma conta. Assim o usuário pode editar o e-mail e desabilitar ou habilitar a caixa de texto para o "Envio de E-mail". Eu optei por assinalar habilitado por padrão, pois é comum se receber um feedback ao preencher um e-mail em um formulário. De fato estou ciente de que interfaces personalizadas e atraentes podem ser facilmente construídas com o VisualForce, Aura e/ou Lightning Web Components. No entanto, para esta necessidade simples, optei por integrar a funcionalidade diretamente ao formulário padrão de preenchimento da conta. Acredito que isso possa fazer mais sentido para o usuário, já que ele está familiarizado com esse formulário e não precisará alternar entre interfaces diferentes para realizar a tarefa desejada


### Incrementar o Valor Total de Vendas de Uma Conta

Para automatizar o cálculo do campo customizado "Valor Total de Vendas" relacionado a uma conta, sem a necessidade de escrever código, isto poderia ser efetuado com um fluxo de automação fornecido pelo Salesforce. Porém, uma vez que a funcionalidade de automação solicitada é simples, temos o requisito do tempo de entrega e somando-se ao fato de haver um relacionamento de Mestre e detalhes entre os objetos Conta e Ordem, sendo o primeiro o mestre e o segundo o detalhe, construí o campo Valor total de Vendas como um resumo de totalização, onde se faz um somatório dos valores das Ordens atribuídas a Conta a cada vez que se insere ou se edita o valor de uma Ordem relacionada a esta conta.

### Processo Automático Para Excluir Pedidos Modificados a Mais de Três Meses

Para a realização desta automação, implementei uma classe chamada RemoveOldOrders, a qual captura a data correspondente a três meses atrás com relação a data atual. Depois eu armazeno em uma estrutura de dados do tipo lista, a qual é atribuída o resultada da pesquisa SOQL que captura o identificador único de todas as ordens cuja a data de modificação ocorreu há três meses ou mais. Então esta lista, caso não seja vazia, deletada. Faz-se uma boa prática armazenar estes registros em uma lista a fim de que seja feita uma deleção em massa. No entanto, a fim de que esta operação aconteça diariamente, caso respeitadas às condiçãos de data de modificaçãos iguais ou superiores há três meses, a esta classe foi implementada a interface "Schedulable", sendo permitido que ela seja anexada a uma agenda para execução em determinados intervalos de tempo. Para este caso, eu a programei para que ela seja chamada todos os dias as 00:00 até o último dia deste ano;

## 👤 Integrante

Ademais, foi criado um usuário para o avaliador, conforme os requisitos presentes no desafio.

## ⚙️ Como Executar na sua máquina 
-  Clone o projeto com o seguinte comando: 
    ```
    https://github.com/Ermeson23/desafio-globo.git
    ```

## 💻 Recursos Externos Utilizados
- [Workbench - Ferramenta utilizada Para Testes dos EndPoints Customizados](https://workbench.developerforce.com)
    - Assinale os campos de Environment: Production
    - API Version: (Deixar o padrão)
    - Marque o checkbox(caixa de texto) para Aceitar os termos
    - Clique em Login com Salesforce

    - Ao efetuar o login com as credenciais da conta
    - Escolher, no item da barra de navegação: "Utility", o valor "Rest Explorer";

    - Assinalar o método HTTP correto
    - Para testar os endpoints customizados, oferecer no valor do path: /services/apexrest/nomeDoMetodo
    - caso seja preciso, a depender do método HTTP, inserir um corpo da requisição
    - clicar no execute e verificar as mensagens na tela
    - Se as mensagens são de sucesso, verificar as alterações efetuadas na Organização Salesforce
- [Salesforce](https://login.salesforce.com/)

- [Package Bulder](https://packagebuilder.herokuapp.com/)


## Observação Final
Na elaboração desta solução, me esforcei para empregar nomes descritivos para classes, variáveis, campos, e assim por diante, com o intuito de minimizar, ou até mesmo eliminar, a necessidade de comentários adicionais, esforçando-me para escrever um código autoexplicativo.