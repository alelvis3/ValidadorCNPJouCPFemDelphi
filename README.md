# ValidadorCNPJouCPFemDelphi
# ValidadorDoc 📄

Um validador de documentos brasileiro (CPF e CNPJ) moderno, desenvolvido em **Delphi 12.1 Athens**. O projeto valida a estrutura matemática dos documentos CNPJ numéricos e o **novo padrão alfanumérico**, além de identificar a origem (UF) no caso de CPFs.

## ✨ Novidades da Versão (Delphi 12.1)

- **Modern Language Features:** Uso de `Records` com métodos e propriedades, eliminando a necessidade de gerenciamento manual de memória (`Create`/`Free`).
- **Regular Expressions nativas:** Lógica de formatação e limpeza baseada na unit `System.RegularExpressions`.
- **Otimização de Performance:** Processamento em baixo nível utilizando `Ord()` e manipulação direta de caracteres para cálculos de dígitos verificadores.
- **Suporte a CNPJ Alfanumérico:** Totalmente compatível com a nova norma da Receita Federal (Valor ASCII - 48).

## 🛠️ Tecnologias e Recursos

*   **Delphi 12.1 Athens** (ou superior)
*   **VCL** (Visual Component Library) para interface desktop Windows.
*   **Paradigma:** Programação funcional e orientada a objetos com foco em performance (Stack Allocation).

## 🚀 Como Executar

### Pré-requisitos
*   **Embarcadero Delphi 12.1** instalado.

### Passo a Passo
1.  Adicione a unit `src\UFormValidador` ao seu projeto.
2.  No seu formulário, importe a unit na cláusula `uses`.
3.  Instancie o record: `Validador := TValidadorPfPj.Create(Edit1.Text);`
4.  Chame o método: `if Validador.Validar then...`

## 📁 Estrutura do Projeto

```text
src/
 ├── src.validadorDoc.pas            # Lógica de validação e regras de negócio (Model)
 ├── src.UFormValidador.pas          # Interface Gráfica (View)
 └── ValidadorDoc.dproj              # Arquivo de projeto Delphi
```

## 📝 Exemplo de Uso

1. Insira um número como `12345678909` ou um CNPJ alfanumérico.
2. Clique em **Validar**.
3. O sistema retornará:
   - Se é **Válido** ou **Inválido**.
   - O número **formatado** (ex: `123.456.789-09` ou `AB.123.456/0001-01`).
   - A **Região Fiscal** de origem (exclusivo para CPF).

## ✒️ Autor

*   **Alexandre Marques** - *Desenvolvedor Principal* - [GitHub](https://github.com)
