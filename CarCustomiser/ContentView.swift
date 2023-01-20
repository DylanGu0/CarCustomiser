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
    @State private var remainingFunds = 1000
    
    var exhaustPackageDisabled: Bool {
        if remainingFunds < 500 && exhaustPackage == false {
            return true
        }
        return false
    }
    
    var tiresPackageDisabled: Bool {
        if remainingFunds < 500 && tiresPackage == false {
            return true
        }
        return false
    }
    
    var turboBoostDisabled: Bool {
        if remainingFunds < 500 && turboBoost == false {
            return true
        }
        return false
    }
    
    var extraWeightDisabled: Bool {
        if remainingFunds < 1000 && extraWeight == false {
            return true
        }
        return false
    }
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 10
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
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
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration += 5
                    starterCars.cars[selectedCar].handling += 1
                    remainingFunds += 500
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
                    remainingFunds -= 1000
                } else {
                    starterCars.cars[selectedCar].acceleration -= 3
                    starterCars.cars[selectedCar].topSpeed -= 15
                    remainingFunds += 1000
                }
            }
        )
        
        VStack {
            Form {
                VStack(alignment: .leading, spacing: 20) {
                    Text(starterCars.cars[selectedCar].displayStats())
                    Button("Next Car", action: {
                        selectedCar += 1
                        resetDisplay()
                        if selectedCar == starterCars.cars.count{
                            selectedCar = 0
                        }
                    })
                }
                Section {
                    Toggle("Exhaust Package     (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(exhaustPackageDisabled)
                    Toggle("Tires Package     (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(tiresPackageDisabled)
                    Toggle("Turbo Boost     (Cost: 500)", isOn: turboBoostBinding)
                        .disabled(turboBoostDisabled)
                    Toggle("Extra Weight     (Cost: 1000)", isOn: extraWeightBinding)
                        .disabled(extraWeightDisabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
                .baselineOffset(20)
        }
    }
    
    func resetDisplay() {
        starterCars = StarterCars()
        exhaustPackage = false
        tiresPackage = false
        turboBoost = false
        extraWeight = false
        remainingFunds = 1000
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
