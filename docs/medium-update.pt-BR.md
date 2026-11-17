# Revisão completa do tutorial da calculadora

Data: 17 de novembro de 2026.

Artigo: [Desenvolvimento de uma Calculadora simples com Flutter](https://medium.com/flutter-comunidade-br/desenvolvimento-de-uma-calculadora-simples-com-flutter-56106baae51), de Kleber Andrade. O link original http://bit.ly/3amM3EK foi resolvido para o identificador 56106baae51.

## Estado publicado e verificado

A revisão completa foi salva por **Save and publish** na conta do autor. O navegador retornou ao artigo com a mesma URL/identidade e o parâmetro postPublishedType=repub. A página publicada foi lida e conferida, não apenas o rascunho. Nenhuma newsletter, mensagem ou opção de e-mail a assinantes foi acionada.

- Capa nova, ilustrativa, selecionada como imagem de destaque e creditada como criada com auxílio de IA.
- Duas capturas novas da aplicação real no Chrome com Flutter 3.50.0 / Dart 3.14.0 / material_ui 1.11.1, incluindo viewport 390×844. Não são testes em telefone físico.
- Três imagens hospedadas pelo Medium, todas com legendas e descrições alternativas.
- Aula reorganizada em oito etapas: resultado, instalação, packages, domínio, transições, erros, interface e verificações.
- Nove blocos de código nativos do Medium, com linguagens definidas explicitamente. Todos foram extraídos novamente da página publicada e comparados com os exemplos preparados: conteúdo idêntico, preservando hífens, aspas, quebras e indentação. Linhas em branco supérfluas foram removidas para que cada exemplo fique em um bloco copiável.
- Inventário completo das 31 dependências resolvidas, versões diretas e toolchain no próprio texto. A migração para o pacote oficial material_ui está explicada.
- O relatório pub outdated confirmou nenhuma diferença entre Current, Upgradable e Resolvable. As únicas diferenças em Latest são material_color_utilities 0.13.0 → 0.13.1 e test_api 0.7.14 → 0.7.15, ambas fixadas pelo SDK. Não foram usados overrides incompatíveis.
- Exatamente cinco exercícios encerram o conteúdo: tipografia, ícone, inicialização, copiar resultado e histórico. Cada exercício tem critérios de conclusão e orienta validação.
- Autoria, português, título e propósito didático preservados. A introdução histórica, imagens antigas e links da aula de 2020 continuam acessíveis no material original do repositório; o corpo anterior à revisão completa também foi guardado em HTML. Nenhum artigo de terceiros ou gist incorporado foi alterado separadamente.

## Evidências e fontes

- [Captura da página publicada](screenshots/medium-published-v2.jpg).
- [Fonte editorial da aula](medium-lesson.pt-BR.html).
- [Verificação extraída da página publicada](medium-publication-proof.json).
- [Inventário explicado](dependencies.md) e [relatório do resolvedor](dependency-audit.json).
- [Proveniência e prompt da capa](cover-provenance.txt).
- [Corpo anterior da aula](medium-before-full-revision.html) e [material de 2020](classroom-original.pt-BR.md).

## Regra editorial para revisões futuras

Concluir sempre com exatamente cinco exercícios práticos, atualizar capa/imagens/códigos quando deixarem de representar a implementação e conferir as versões no projeto antes de reproduzi-las no texto. Documentar versões fixadas pelo SDK em vez de alegar que uma combinação incompatível foi instalada. Só declarar publicação após conferir a página pública.
