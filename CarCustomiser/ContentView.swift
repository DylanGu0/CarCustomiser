//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Guo, Dylan (Coll) on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var turboBoost = false
    @State private var extraWeight = false
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 10
                }
            }
        )
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                }
            }
        )
        let turboBoostBinding = Binding<Bool> (
            get: { self.turboBoost },
            set: { newValue in
                self.turboBoost = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 5
                    starterCars.cars[selectedCar].handling -= 1
                } else {
                    starterCars.cars[selectedCar].acceleration += 5
                    starterCars.cars[selectedCar].handling += 1
                }
            }
        )
        let extraWeightBinding = Binding<Bool> (
            get: { self.extraWeight },
            set: { newValue in
                self.extraWeight = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration += 3
                    starterCars.cars[selectedCar].topSpeed += 15
                } else {
                    starterCars.cars[selectedCar].acceleration -= 3
                    starterCars.cars[selectedCar].topSpeed -= 15
                }
            }
        )
        Form {
            VStack(alignment: .leading, spacing: 20) {
                Text(starterCars.cars[selectedCar].displayStats())
                Button("Next Car", action: {
                    selectedCar += 1
                    if selectedCar == starterCars.cars.count{
                        selectedCar = 0
                    }
                })
            }
            Section {
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tires Package", isOn: tiresPackageBinding)
                Toggle("Turbo Boost", isOn: turboBoostBinding)
                Toggle("Extra Weight", isOn: extraWeightBinding)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
