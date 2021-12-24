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

### SOLUÇÃO API
Foi criada uma API para uma página web disponível em: [Stone challenge](https://stone-challenge-serverless.s3.us-east-1.amazonaws.com/index.html?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGIaCXNhLWVhc3QtMSJHMEUCIQD2wIjwu1E6fQ02CfeBLVtlxVZ3hD5PlaKD6fP%2B419tBQIgLyahcSqyHXwVxYwXcsYLk6RSuTpDsrpz6oEHHpf1YIsq9gIIWxAAGgw4MTQ3MzU3NDA3NTYiDBQwa2Vqkj2y3LvibSrTAhwqqomm6bLLROlxPLHIo4D0cDAchafHC25L6iE0VgX%2BttiAQsIgIRLWjTG9K0MHQn%2BTFEPsOhUFqrwVTiUuuSiVLMwq6k%2BuIKnZd4AHRns7xVcQ7Ai%2BTH8NTnw2XL3B%2FO1rYjNt%2FvkdNFuoW2GnOyzI4cY2r3%2BPrvMpyP6OeMSsqzzUHzOh721r6f%2BUhtp8riTNudQaPKjVexTu43mFJamc%2FACvZ%2B8B98BfFSi8L1oUQCOhLlWb2DDUBrXibO7MUD5ZlkODDXJkxferx0yodv64X8o0babQK60sJuzOqtf6XzHz1RQgAq05CzCJsK5I2%2B%2FB1nhuf%2FehS%2Bf8pAT%2BqiAAqT7frqgOm1mzbsYIQRY78ChS5NHBbLWq8k5BbUnFljx6nXIiMwIujFpYodVR%2BKmjRuyEp7PNn8z0eMiOOs%2BFKzbR%2BLiFOtwi0Coq2lr68sWFRTDfwJSOBjqzArt1oyOhWsvMyEioERTWEkHb8iPdaQhEEEYoaB%2F5E4cL5R1upSSbBZn1sskcBzgPPy212WIYpOW7NayTiQSVgYjYhTvyKuXVMFX6vOCapuSPusEURis20XdqkhINsMutgSwcJC%2BdFSXpRPH2H6uxTERnVmilyQEfZK3Ys4Xbuwk4Kb0lYZ0PCnXaDojm8n8LcXAWKuJURpUEJmOwWkISO4QLQbf24fJzlsNhk2t42Vp8Mj%2FEHvDwIfp33IIsGkndVqJORAy79gWuAkncxsX2V6yVBOddo%2FYpUBNC%2FT7zLRvzbX0EvPNd75cR921odXsNJAPixcX%2F%2F3LSQJttVYUWA6aNzE3YnSmNLtO6wAZvAli4wr18A4usZiyniMCd0x46Oal%2BpgpxRM57IYpg9zx0LbjGc7o%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211224T100843Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604800&X-Amz-Credential=ASIA33MQIZ5KCTOESZOU%2F20211224%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=483b4350fa2dac391f663e55c096983922f3d45b53ec190ab850e963835e8a57) que está hospedado numa bucket S3 e faz a requisição via get.

### DESAFIOS ENFRENTADOS
- Devido a nunca ter feito um deploy de uma máquina Windows na AWS, tive problemas para pegar a senha do administrador, creio que com mais tempo, consigo pegar essa senha e realizar corretamente o deploy das máquinas Windows.
- Devido a ter o problema com os servidores Windows, perdi muito tempo nessa solução tendo problemas de tempo para automatizar a terceira solução proposta que é `Desenvolver uma API, na linguagem deseja, que retorne uma mensagem de "Hello World!" tanto em uma requisição GET como POST.` Fiz a solução manualmente, falta automatizar.

### MELHORIAS QUE GOSTARIA DE FAZER
- Gostaria de fazer um pipeline para realizar o destroy do ambiente.
- Gostaria de fazer a criação dos servidores em alta disponibilidade, colocando um ELB redirecionando as requisições para os servidores.

References:

  https://blog.searce.com/jenkins-change-the-forgotten-password-525169ba1c34