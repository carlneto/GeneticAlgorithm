import SwiftUI
import UtilsPackage

struct ContentView: View {
   private static let base = 10
   @State private var populationSize: Int = base * 3
   @State private var populationPercent = 0.8
   @State private var geneLength: Int = base * 10
   @State private var generations: Int = base * 50
   @State private var bestIndividual: String = "...Nenhum..."
   @State private var guess: String = "..."
   @State private var isRunning: Bool = false
   
   var body: some View {
      VStack {
         Text("Algoritmo Genético").font(.title).padding()
         
         Form {
            Section(header: Text("Parâmetros")) {
               Stepper(value: $populationSize, in: 5...500, step: 1) {
                  Text("Tamanho da População: \(populationSize)")
               }
               Slider(value: $populationPercent, in: 0.0...1.0) {
                  Text("Percentagem de clones: \(populationPercent, specifier: "%.2f")")
               }
               Stepper(value: $geneLength, in: 5...100, step: 5) {
                  Text("Tamanho do Genoma: \(geneLength)")
               }
               .onChange(of: geneLength) { _, newValue in
//                  populationSize = newValue * 2
//                  generations = newValue
               }
               Stepper(value: $generations, in: 5...1000, step: 5) {
                  Text("Número de Gerações: \(generations)")
               }
            }
         }
         .padding()
         Button(action: startAlgorithm) {
            Text(isRunning ? "Executando..." : "Iniciar Algoritmo Genético")
               .padding()
               .background(isRunning ? Color.gray : Color.blue)
               .foregroundColor(.white)
               .cornerRadius(8)
         }
         .disabled(isRunning)
         
         Text("\nProcurando a solução:\n")
            .font(.headline)
            .foregroundColor(.blue)
         
         Text(guess)
            .font(.body)
            .multilineTextAlignment(.center)
         
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
         var genes = [Int]()
         for _ in 1...geneLength {
            genes.append(Int.random(in: 0...9))
         }
         guess = genes.map{ "\($0)" }.joined()
         print("- Solução: \(guess)")

         let algorithm = GeneticAlgorithm(
            populationSize: populationSize,
            populationPercent: populationPercent,
            geneLength: geneLength,
            generations: generations,
            bestFitness: { $0 < $1 },
            fitnessFunction: { $0.genes.euclideanDistance(to: genes) }
         )
         
         algorithm.run { msg in
            DispatchQueue.main.async {
               self.bestIndividual = msg
            }
         }
         
         if let best = algorithm.population.individuals.first {
            DispatchQueue.main.async {
               self.bestIndividual = best.str
               if best.genes == genes {
                  self.guess = "Parabéns encontrou!"
               }
               self.isRunning = false
            }
            print("- Solução: \(guess)")
         }
      }
   }
}
