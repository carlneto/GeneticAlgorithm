import SwiftUI
import UtilsPackage

struct ContentView: View {
   private static let base = 10
   @State private var populationSize: Int = base * 10 * 3
   @State private var geneLength: Int = base * 10
   @State private var starving: Int = 5
   @State private var topPercent: Double = 0.15
   @State private var mutationRate: Double = 0.07
   @State private var crossoverRate: Double = 0.68
   @State private var generations: Int = base * 4
   @State private var bestIndividual: String = "...Nenhum..."
   @State private var isRunning: Bool = false
   @State private var isOn: Bool = true
   
   var body: some View {
      VStack {
         Text("Algoritmo Genético").font(.title).padding()
         
         Form {
            Section(header: Text("Parâmetros")) {
               Stepper(value: $populationSize, in: 10...1000, step: 10) {
                  Text("Tamanho da População: \(populationSize)")
               }
               Stepper(value: $geneLength, in: 5...100, step: 5) {
                  Text("Tamanho do Genoma: \(geneLength)")
               }
               .onChange(of: geneLength) { _, newValue in
                  populationSize = newValue * 3
                  generations = 4 * newValue / 10
               }
               Stepper(value: $starving, in: 4...10, step: 1) {
                  Text("Sem Melhoras: \(starving)")
               }
               Slider(value: $topPercent, in: 0.0...1.0) {
                  Text("Taxa de Melhores: \(topPercent, specifier: "%.2f")")
               }
               Slider(value: $mutationRate, in: 0.0...1.0) {
                  Text("Taxa de Mutação: \(mutationRate, specifier: "%.2f")")
               }
               Slider(value: $crossoverRate, in: 0.0...1.0) {
                  Text("Taxa de Crossover: \(crossoverRate, specifier: "%.2f")")
               }
               Stepper(value: $generations, in: 1...1000, step: 5) {
                  Text("Número de Gerações: \(generations)")
               }
            }
         }
         .padding()
         
         HStack {
            Toggle(isOn: $isOn) {
               Text("Valor:")
            }
            if isOn {
               Text("Maior")
            } else {
               Text("Menor")
            }
         }
         Button(action: startAlgorithm) {
            Text(isRunning ? "Executando..." : "Iniciar Algoritmo Genético")
               .padding()
               .background(isRunning ? Color.gray : Color.blue)
               .foregroundColor(.white)
               .cornerRadius(8)
         }
         .disabled(isRunning)

         Text("\nMelhor Indivíduo:")
            .font(.headline)
            .foregroundColor(.blue)
         
         Text(bestIndividual)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
         
         Spacer()
      }
      .padding()
      .frame(minWidth: 400, minHeight: 400)
   }
   
   func startAlgorithm() {
      isRunning = true
      DispatchQueue.main.async {
         self.bestIndividual = "..."
      }
      DispatchQueue.global(qos: .background).async {
         let algorithm = GeneticAlgorithm(
            populationSize: populationSize,
            geneLength: geneLength, 
            starving: starving,
            topPercent: topPercent,
            mutationRate: mutationRate,
            crossoverRate: crossoverRate,
            generations: generations,
            bestFitness: isOn ? { $0 > $1 } : { $0 < $1 },
            fitnessFunction: { Double($0.genes.reduce(0, +)) }
         )
         
         algorithm.run { msg in
            DispatchQueue.main.async {
               self.bestIndividual = msg
            }
         }
         
         if let best = algorithm.population.individuals.first {
            DispatchQueue.main.async {
               self.bestIndividual = best.str
               self.isRunning = false
            }
         }
      }
   }
}
