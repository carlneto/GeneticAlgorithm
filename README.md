# 🧬 Algoritmo Genético em SwiftUI: O Desafio da Sequência

---

## 2. 📝 Descrição do Projeto

Este projeto é uma **demonstração interativa** de um **Algoritmo Genético** (AG) implementado em **Swift** e **SwiftUI**. O objetivo do AG é encontrar uma **sequência numérica alvo** (o "genoma" ideal) gerada aleatoriamente no início da execução, utilizando os princípios da evolução natural: **seleção, *crossover* (recombinação) e mutação**.

A aplicação permite ajustar os principais parâmetros do algoritmo (tamanho da população, percentagem de clonagem, etc.) através de uma interface gráfica, permitindo ao utilizador observar como as alterações nos parâmetros influenciam a velocidade e a capacidade do AG para convergir para a solução.

---

## 3. 🛠️ Requisitos

Para compilar e executar este projeto, são necessários os seguintes requisitos:

* **Sistema Operativo:** macOS 12.0+ (Monterey) ou superior.
* **Ambiente de Desenvolvimento:** Xcode 14.0 ou superior.
* **Linguagem:** Swift 5.7 ou superior.

---

## 4. ⚙️ Instalação

Siga estes passos para configurar o projeto no seu ambiente de desenvolvimento:

1.  **Clonar o Repositório:** (Assumindo que o código está num repositório Git, substitua pelo seu comando)
    ```bash
    git clone git@github.com:carlneto/GeneticAlgorithm.git
    ```
2.  **Abrir o Projeto:** Navegue até à pasta do projeto e abra o ficheiro `.xcodeproj` ou `.xcworkspace` (se aplicável) no **Xcode**.
3.  **Compilar e Executar:** Selecione um alvo de execução (por exemplo, um simulador macOS App) e clique no botão **Run** (▶️) ou pressione `⌘R`.

---

## 5. 🚀 Uso

O uso da aplicação é simples e direto:

1.  **Ajustar Parâmetros:** Na secção **"Parâmetros"**, defina os valores desejados para:
    * **Tamanho da População:** Quantos indivíduos existem em cada geração.
    * **Percentagem de *Clones*:** A fração dos melhores indivíduos que são copiados diretamente para a próxima geração sem modificação (elitismo).
    * **Tamanho do Genoma:** O comprimento da sequência numérica alvo que o AG tentará encontrar.
    * **Número de Gerações:** O número máximo de ciclos de evolução que o AG irá executar.
2.  **Iniciar a Execução:** Clique no botão **"Iniciar Algoritmo Genético"**.
3.  **Observar Resultados:** A aplicação irá gerar uma sequência alvo (o `guess`), e o `bestIndividual` (Melhor Indivíduo) mostrará a sequência que mais se aproxima da alvo em cada geração.

O algoritmo termina quando a sequência alvo é encontrada (A mensagem `Procurando a solução:` muda para `Parabéns encontrou!`) ou o número máximo de gerações é atingido.

---

## 6. 📁 Estrutura do Projeto

A estrutura do projeto está organizada para separar a lógica do algoritmo (`GeneticAlgorithm`) da interface do utilizador (`SwiftUI`).

| Ficheiro/Pasta | Descrição |
| :--- | :--- |
| `GeneticAlgorithmApp.swift` | O ponto de entrada principal da aplicação SwiftUI. |
| `ContentView.swift` | Contém a vista principal da UI (SwiftUI) e gere a lógica de **parâmetros** e o acionamento (`startAlgorithm`) do algoritmo. |
| `GeneticAlgorithm/` (A assumir) | **A Lógica do AG.** Deve conter classes/estruturas como `Individual`, `Population`, e a classe principal `GeneticAlgorithm` que gere o ciclo evolutivo. |
| `Extensions/` (A assumir) | Ficheiros de extensão, como a função `euclideanDistance(to:)` para calcular o *fitness* (aptidão) do indivíduo. |

---

## 7. ✨ Funcionalidades Principais

* **Definição de Parâmetros:** Configuração da população, genoma e gerações através de *Steppers* e *Sliders* no SwiftUI.
* **Assincronia (`DispatchQueue`):** O algoritmo de longa duração é executado numa fila de segundo plano (`qos: .background`) para garantir que a interface do utilizador se mantém responsiva e atualizada.
* ***Fitness* Baseado em Distância Euclidiana:** A função de aptidão (`fitnessFunction`) mede a distância euclidiana entre o genoma do indivíduo e a sequência alvo. Quanto **menor** a distância, **melhor** é o *fitness* (o objetivo é minimizar a distância).
* **Elitismo:** O parâmetro `populationPercent` permite clonar os melhores indivíduos para a próxima geração, garantindo que as melhores soluções não são perdidas.
* **Arquitetura SwiftUI:** Interface limpa e reativa, aproveitando as *Property Wrappers* (`@State`) para gerir o estado da aplicação.

---

## 8. 📜 Licença

O código-fonte deste projeto está sujeito a uma **Licença de Utilização Restrita**.

**Resumo das Condições:**

* **PROIBIÇÕES:** É estritamente proibida a **modificação**, **distribuição** (pública ou privada), e **utilização comercial** sem autorização expressa por escrito do autor. É igualmente proibido o registo de quaisquer novos direitos de propriedade intelectual (patentes, etc.).
* **PROPRIEDADE:** O software e todos os materiais associados são propriedade exclusiva do autor.
* **USO PERMITIDO:** A utilização é permitida apenas para fins **estritamente pessoais, privados e não comerciais**, com o único propósito de **avaliação e testes**.
* **ISENÇÃO:** O software é fornecido **"AS IS"** (tal como está), sem quaisquer garantias. O autor não se responsabiliza por quaisquer danos resultantes do uso ou da impossibilidade de uso do software.

**Qualquer uso que exceda a avaliação pessoal requer autorização por escrito.**

---

## 9. 🧑‍💻 Créditos / Autor

* **Autor:** carlneto
* **Data:** 2025
