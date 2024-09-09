import SwiftUI
import UtilsPackage

struct ContentView: View {
   @State private var populationSize = 100
   @State private var mutationRate = 0.03
   @State private var generations = 500
   @State private var bestFitnessOverTime: [Double] = []
   @State private var showingEvolution = false
   
   var body: some View {
      NavigationStack {
         VStack {
            Form {
               Section(header: Text("Configuração do Algoritmo Genético")) {
                  Stepper(value: $populationSize, in: 10...1000) {
                     Text("Tamanho da População: \(populationSize)")
                  }
                  Slider(value: $mutationRate, in: 0...1) {
                     Text("Taxa de Mutação: \(mutationRate, specifier: "%.2f")")
                  }
                  Stepper(value: $generations, in: 10...1000) {
                     Text("Número de Gerações: \(generations)")
                  }
               }
               
               Button(action: {
                  runGeneticAlgorithm()
                  showingEvolution = true
               }) {
                  Text("Iniciar Algoritmo Genético")
                     .frame(maxWidth: .infinity)
                     .padding()
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(8)
               }
            }
            .padding()
         }
         .navigationTitle("Configuração")
         .navigationDestination(isPresented: $showingEvolution) {
            EvolutionView(generations: bestFitnessOverTime)
         }
      }
   }
   
   // Função para rodar o algoritmo genético
   func runGeneticAlgorithm() {
      // Inicialização da população
      let population: [Individual<Bool>] = (0..<populationSize).map { _ in
         let chromosome = Chromosome<Bool>.binary((0..<10).map { _ in Bool.random() })
         return Individual(chromosome: chromosome)
      }
      
      // Definindo componentes do algoritmo
      let fitnessFunction = ExampleFitnessFunction()
      let selectionStrategy = RouletteWheelSelection<Bool>()
      let crossoverOperator = OnePointCrossover<Bool>()
      let mutationOperator = BitFlipMutation()
      let terminationCondition = TerminationCondition.maxGenerations(generations)
      
      // Configuração e execução do algoritmo
      var geneticAlgorithm = GeneticAlgorithm(
         population: population,
         fitnessFunction: fitnessFunction,
         selectionStrategy: selectionStrategy,
         crossoverOperator: crossoverOperator,
         mutationOperator: mutationOperator,
         elitism: true,
         nicheSize: nil
      )
      
      // Evolui e armazena a melhor aptidão em cada geração
      bestFitnessOverTime = []
      for _ in 0..<generations {
         geneticAlgorithm.evolve(generations: 1, terminationCondition: terminationCondition)
         if let bestFitness = geneticAlgorithm.population.map({ $0.fitness }).max() {
            bestFitnessOverTime.append(bestFitness)
         }
      }
   }
}

// Função de aptidão de exemplo
struct ExampleFitnessFunction: FitnessFunction {
   func evaluate(individual: Individual<Bool>) -> Double {
      if case .binary(let chromosome) = individual.chromosome {
         // Avalia a aptidão como a soma dos bits
         return Double(chromosome.filter { $0 }.count)
      }
      return 0.0
   }
}

// MARK: - Visualização da Evolução
struct EvolutionView: View {
   var generations: [Double]
   
   var body: some View {
      VStack {
         Text("Evolução da Aptidão")
            .font(.headline)
            .padding()
         LineGraph(data: generations)
            .padding()
         Spacer()
      }
      .navigationTitle("Resultado")
   }
}

// MARK: - Visualização de Gráfico (exemplo simples)
struct LineGraph: View {
   var data: [Double]
   
   var body: some View {
      GeometryReader { geometry in
         Path { path in
            let width = geometry.size.width
            let height = geometry.size.height
            let step = width / CGFloat(data.count - 1)
            
            path.move(to: CGPoint(x: 0, y: height * CGFloat(1 - data[0])))
            
            for i in 1..<data.count {
               let point = CGPoint(x: step * CGFloat(i), y: height * CGFloat(1 - data[i] / (data.max() ?? 1.0)))
               path.addLine(to: point)
            }
         }
         .stroke(Color.blue, lineWidth: 2)
      }
   }
}
