# 🧬 Genetic Algorithm in SwiftUI: The Sequence Challenge

![Swift](https://img.shields.io/badge/Swift-5.7-orange?logo=swift)
![Platform](https://img.shields.io/badge/Platform-macOS_12+-lightgrey?logo=apple)
![License](https://img.shields.io/badge/License-Restricted-red)
![UI](https://img.shields.io/badge/SwiftUI-Enabled-blue?logo=swift)

---

## 📖 Overview

This project is an **interactive demonstration** of a **Genetic Algorithm (GA)** implemented in **Swift** and **SwiftUI**.
At runtime, the app generates a random **target numeric sequence**, and the GA attempts to discover that sequence using evolutionary principles:

* **Selection**
* **Crossover (recombination)**
* **Mutation**

Users can adjust the main algorithm parameters through a graphical interface, allowing real-time observation of how different configurations affect convergence speed and accuracy.

---

## 📝 Features

* **Interactive Parameter Control**

  * Population size
  * Clone percentage (elitism)
  * Genome length
  * Maximum number of generations

* **Euclidean Distance Fitness Function** measuring similarity to the target sequence.

* **Elitism Support** ensuring that the best individuals persist between generations.

* **Fully Asynchronous Execution** using a background queue to keep the UI responsive.

* **SwiftUI Reactive Interface** using `@State` and modern state-driven design.

* **Clear Visualization** of the target sequence, current best individual, and progress messages.

---

## 🛠 Requirements

To build and run the project, you will need:

* **Operating System:** macOS 12.0 (Monterey) or later
* **Development Environment:** Xcode 14.0 or later
* **Language:** Swift 5.7 or later

---

## ⚙️ Installation

1. **Clone the Repository**

   ```bash
   git clone [YOUR_REPOSITORY_URL]
   ```

2. **Open the Project**
   Open the `.xcodeproj` or `.xcworkspace` file in **Xcode**.

3. **Build & Run**
   Choose a macOS target (simulator or Mac app) and press **Run** (`⌘R`).

---

## 🚀 How to Use

1. **Set Parameters** under the *Parameters* section:

   * **Population Size:** number of individuals per generation
   * **Clone Percentage:** fraction of top individuals copied directly to the next generation
   * **Genome Size:** length of the numeric sequence to be discovered
   * **Generation Count:** maximum number of evolutionary cycles

2. **Start the Algorithm**
   Click **Start Genetic Algorithm**.

3. **Watch the Evolution**

   * The app generates a **target sequence** (“guess”).
   * Each generation attempts to produce a **best individual** closer to the target.
   * The search stops when the sequence is found or when the maximum generation limit is reached.

---

## 📁 Project Structure

| File / Folder               | Description                                                               |
| --------------------------- | ------------------------------------------------------------------------- |
| `GeneticAlgorithmApp.swift` | Main SwiftUI application entry point.                                     |
| `ContentView.swift`         | Primary SwiftUI interface, parameter controls, and algorithm trigger.     |
| `GeneticAlgorithm/`         | Core GA logic: `Individual`, `Population`, `GeneticAlgorithm` controller. |
| `Extensions/`               | Utilities such as `euclideanDistance(to:)` for computing fitness.         |

---

## 🧠 Technical Highlights

### 🎯 Fitness Function: Euclidean Distance

The GA evaluates individuals using the Euclidean distance between their genome and the target sequence.
Lower distance = higher fitness.

### 🧬 Crossover & Mutation

The algorithm combines parent genomes and introduces random mutations to explore the solution space.

### 🏆 Elitism

A configurable percentage of the best individuals survives unchanged to the next generation, improving stability.

### 🔄 Asynchronous Execution

The evolutionary loop runs on a background queue (`qos: .background`), ensuring the UI remains smooth and reactive.

---

## 📜 License (Restricted Use)

This project is distributed under a **Restricted Use License**.

### ❌ Prohibited

* Modification
* Redistribution (public or private)
* Commercial use
* Claiming new IP rights (e.g., patents)

### ✔️ Permitted

* **Personal, private, non-commercial use only**
* Intended exclusively for **evaluation and testing**

### ⚠️ Disclaimer

The software is provided **“AS IS”**, without any warranties.
The author is not responsible for damages caused by use or inability to use the software.

**Any use beyond personal evaluation requires written authorization.**

---

## 👤 Author

* **Author:** carlneto
* **Year:** 2025
