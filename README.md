# Stone Challenge

A proposta é provisionar uma infraestrutura via servidor jenkins onde esse servidor possui duas pipelines, uma para criação de uma infraestrutura na AWS usando o terraform.

Essa infra será composta de:

- Dois servidores Linux t2.micro com Apache para hospedagem da página web **helloworld.html**

- Dois servidores Windows com Apache, hospedando também a página web **helloworld.html**

- Uma página hospedada no bucket S3 da amazon utilizando um API Gateway para

  
  A solução proposta foi a criação de um servidor Jenkins e a partir desse servidor Jenkins, será disparado a ação de criação de dois servers windows e dois linux (**todos hospedados na AWS**) com o apache instalado e com a página inicial de hello world configurada conforme imagem abaixo.

![enter image description here](https://lucid.app/publicSegments/view/b084cfd1-8d08-4a6b-93af-ecaf1d05f8cd/image.png)

O repositório que realiza a criação do servidor jenkins é: https://github.com/gitarena/create_jenkins_server.git

Já o que faz a criação dos webservers é o: https://github.com/gitarena/tis-automation-challenge.git

### SERVIDOR JENKINS
Estrutura da pasta

Para a criação do servidor jenkins basta baixar a solução com o comando:

    git clone https://github.com/gitarena/create_jenkins_server.git

Exportar as suas credenciais da AWS

    export AWS_ACCESS_KEY_ID="AKIAxxxxxxxxxxxx"
    export AWS_SECRET_ACCESS_KEY="KXz2xxxxxxxxxxxxxxxxxxxxxxxx" 

pelo terminal ir até a pasta `create_jenkins_server/deploy_jenkins/terraform/`
e executar o comando: `terraform init && terraform plan && terraform apply --auto-approve`

Ao final da exeução do terraform será chamado um playbook do ansible que fará a configuração do servidor e seus jobs.
![enter image description here](https://lucid.app/publicSegments/view/d91b2c34-533d-47a2-95d7-1ea4d720f530/image.png)
Após a execução do playbook do ansible será informado o nome DNS do servidor jenkins.
O mesmo pode ser acessado via navegador com o nome_dns:8080


### SOLUÇÃO WEBSERVER
A solução webserver pode ser disparada diretamente do servidor jenkins
Basta acessar o servidor Jenkins, acessar o job **webservers** e clicar em **construir agora** e aguardar a execução.
Uma alternativa que pode ser realizada é acessar o servidor via terminal, acessar uma pasta vazia e executar o comando

    git clone https://github.com/gitarena/tis-automation-challenge.git

Exportar as suas credenciais da AWS

    export AWS_ACCESS_KEY_ID="AKIAxxxxxxxxxxxx"
    export AWS_SECRET_ACCESS_KEY="KXz2xxxxxxxxxxxxxxxxxxxxxxxx" 

ir até a pasta `tis-automation-challenge/deploy_webservers/terraform/`
e executar o comando: `terraform init && terraform plan && terraform apply --auto-approve` e aguardar a execução.

Ao final ele dará os nomes DNS dos 4 servidores criados.

### DESAFIOS ENFRENTADOS
- Devido a nunca ter feito um deploy de uma máquina Windows na AWS, tive problemas para pegar a senha do administrador, creio que com mais tempo, consigo pegar essa senha e realizar corretamente o deploy das máquinas Windows.
- Devido a ter o problema com os servidores Windows, perdi muito tempo nessa solução tendo problemas de tempo para automatizar a terceira solução proposta que é `Desenvolver uma API, na linguagem deseja, que retorne uma mensagem de "Hello World!" tanto em uma requisição GET como POST.` Fiz a solução manualmente, falta automatizar.

### MELHORIAS QUE GOSTARIA DE FAZER
- Gostaria de fazer um pipeline para realizar o destroy do ambiente.
- Gostaria de fazer a criação dos servidores em alta disponibilidade, colocando um ELB redirecionando as requisições para os servidores.

References:

  https://blog.searce.com/jenkins-change-the-forgotten-password-525169ba1c34