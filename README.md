# Check Itau

Script para verificar se existem vagas de emprego no banco Itau em determinadas cidades.

### Execução

Primeiramente, instale as dependências:

    bundle install

Depois, crie uma cópia do arquivo `.env.example` com o nome `.env` e preencha os valores correspodentes neste aquivo.

E execute o seguinte comando:

    rake crawler:run['cidade1#cidade2#cidade3', 'seu@email.com']

Substitua o nome das cidades de acordo com sua preferência e o email no qual as vagas serão enviadas. Note que o delimitador é o caractere `#`.

O ideal é que este script seja executado periodicamente. Em ambientes UNIX existe um serviço chamado `cron`. Para criar ou editar uma entrada, execute o seguinte comando:

    crontab -e

Logo após, um editor será exibido. A sintaxe do `crontab` é a seguinte:

    1 2 3 4 5 /caminho/para/comando arg1 arg2

Onde:

    1: Minuto (0-59)
    2: Hora (0-23)
    3: Dia (0-31)
    4: Mes (0-12 [12 == Dezembro])
    5: Dia da semana (0-7 [7 ou 0 == domingo])
    /caminho/para/comando – Script ou nome do comando a ser agendado

Por exemplo, vamos agendar nosso comando para ser executado a cada quatro horas:

    * */4 * * * cd /path/to/project && rake crawler:run['Rio de Janeiro','seu@email.com']
