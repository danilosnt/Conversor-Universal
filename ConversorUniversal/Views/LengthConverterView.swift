import SwiftUI

struct LengthConverterView: View {
    // 1. Input values and state management
    @State private var inputAmount: Double = 0
    @State private var sourceUnit: UnitLength = .meters
    @State private var destinationUnit: UnitLength = .kilometers
    
    // 2. Units array
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
    
    // 3. Formatter to get the full names of the units
    private let formatter: MeasurementFormatter = {
        let f = MeasurementFormatter()
        f.unitOptions = .providedUnit // Uses the specific unit we provide
        f.unitStyle = .long // .long displays "meters" instead of "m"
        return f
    }()
    
    // Helper function to get the name
    func unitName(_ unit: UnitLength) -> String {
        return formatter.string(from: unit).capitalized
    }
    
    // 4. Computed property for logic
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
                            // Here we use the helper function to show the full name
                            Text(unitName(unit)).tag(unit)
                        }
                    }
                    
                    Picker("To:", selection: $destinationUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unitName(unit)).tag(unit)
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
