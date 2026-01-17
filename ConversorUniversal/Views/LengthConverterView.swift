import SwiftUI

struct LengthConverterView: View {
    // 1. Input values and state management
    @State private var inputAmount: Double = 0
    @State private var sourceUnit: UnitLength = .meters
    @State private var destinationUnit: UnitLength = .kilometers
    
    // 2. An array to store our units for the Pickers
    // This avoids repeating code for each unit
    let units: [UnitLength] = [
        .millimeters,
        .centimeters,
        .decimeters,
        .meters,
        .kilometers,
        .inches,
        .feet,
        .yards,
        .miles
    ]
    
    // 3. Computed property to handle the logic
    var conversionResult: Double {
        let sourceMeasurement = Measurement(value: inputAmount, unit: sourceUnit)
        let resultMeasurement = sourceMeasurement.converted(to: destinationUnit)
        return resultMeasurement.value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Input Section
                Section("Input Value") {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                // Selection Section
                Section("Conversion") {
                    Picker("From:", selection: $sourceUnit) {
                        ForEach(units, id: \.self) { unit in
                            // symbol provides "m", "km", etc.
                            Text(unit.symbol).tag(unit)
                        }
                    }
                    
                    Picker("To:", selection: $destinationUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.symbol).tag(unit)
                        }
                    }
                }
                
                // Final Result Section
                Section("Result") {
                    Text(conversionResult, format: .number)
                        .bold()
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Length")
        }
    }
}

#Preview {
    LengthConverterView()
}
