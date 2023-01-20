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
    @State private var remainingTime = 30
    
    var exhaustPackageDisabled: Bool {
        if exhaustPackage == false && remainingFunds < 500 {
            return true
        }
        return remainingTime <= 0 ? true : false
    }
    
    var tiresPackageDisabled: Bool {
        if tiresPackage == false && remainingFunds < 500 {
            return true
        }
        return remainingTime <= 0 ? true : false
    }
    
    var turboBoostDisabled: Bool {
        if turboBoost == false && remainingFunds < 500 {
            return true
        }
        return remainingTime <= 0 ? true : false
    }
    
    var extraWeightDisabled: Bool {
        if extraWeight == false && remainingFunds < 1000 {
            return true
        }
        return remainingTime <= 0 ? true : false
    }
    
    var nextCarDisabled: Bool {
        return remainingTime <= 0 ? true : false
    }
    
    let timer = Timer.publish(every: 1, on:.main, in: .common).autoconnect()
    
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
                    remainingFunds += 500
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
            Text("\(remainingTime)")
                .onReceive(timer) {_ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    }
                }
                .foregroundColor(.red)
            Form {
                VStack(alignment: .leading, spacing: 20) {
                    Text(starterCars.cars[selectedCar].displayStats())
                    Button("Next Car", action: {
                        selectedCar += 1
                        resetDisplay()
                        if selectedCar == starterCars.cars.count{
                            selectedCar = 0
                        }
                    }) .disabled(nextCarDisabled)
                }
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(exhaustPackageDisabled)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(tiresPackageDisabled)
                    Toggle("Turbo Boost (Cost: 500)", isOn: turboBoostBinding)
                        .disabled(turboBoostDisabled)
                    Toggle("Extra Weight (Cost: 1000)", isOn: extraWeightBinding)
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
