# Desafio_Projeto_Logico_Ecommerce
Projeto da criação do projeto lógico de um Ecommerce no MySQL (desafio bootcamp DIO - Suzano)

O Objetivo a princípio era de replicar o modelo lógico do modelo de Ecommerce, do Terceiro desafio de projeto da DIO (Suzano - Analise de dados com Power BI).
Digo a princípio porque, como a ideia principal era realizar inserções e queries utilizando certas cláusulas no MySQL, além de fazer certas adaptações para
outros pontos importantes, resolvi começar o mesmo projeto do 0, utilizando a ideia do projeto mostrado durante os vídeos do desafio como referência.

Os principais objetivos eram:

<img width="1209" height="196" alt="image" src="https://github.com/user-attachments/assets/34295684-1494-461b-a6ce-4c73e0f992f3" />
<img width="693" height="192" alt="image" src="https://github.com/user-attachments/assets/d4fe53ba-c41d-4bf9-940c-cab2acef345e" />

A partir disso, realizei todo o o modelo EER no workbench, além de criar o próprio banco.

Como não existia um cenário muito explicado para seguir, além claro do projeto mostrado nos vídeos, adicionei certos pontos que, ao meu ver,
fazia sentido para um cenário de Ecommerce.Dentre essas adições, posso mencionar:


  1. adicionei uma própria tabela para cpf, utilizando o próprio número como chave primária, além de um atributo tipo para identificar se a chave era
     um CPF ou um CNPJ, além da própria chave relacionando a um único cliente.
  2. Criei uma nova tabela para cartões e endereços, pensando que um mesmo cliente pode cadastrar diversos cartões para pagamento ou endereços para entrega dos
     pedidos.
  3. Adicionei uma tabela relacionada a entrega dos pedidos, e relacionei com os pedidos, onde, cada pedido pode estar ainda sem nenhum id de entrega, ja que, parando
     para pensar, não necessariamente um pedido tem uma entrega logo quando é realizado.
  4. a parte dos estoques não pensei em muita coisa, porque pensei neles apenas como um local da própria empresa de ecommerce, para localizar onde os produtos se encontram
     disponíveis, nada além disso.

em relação as queries, tentei fazer algumas mais complexas e completas, utilizando das cláusulas pedidas no desafio, como não havia um número mínimo de queries, prezei mais pela
eficiência e criatividade das queries. Todas tem um comentário acima dizendo para que cada uma foi usada.

<img width="452" height="134" alt="image" src="https://github.com/user-attachments/assets/79dca918-5d6c-4b36-be65-f997d23d994d" />


Pretendo realizar mais queries futuras para treino próprio, além de revisar possíveis adições e melhorias no projeto em sí.
