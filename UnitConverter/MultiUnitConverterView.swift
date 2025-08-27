//
//  MultiUnitConverterView.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import SwiftUI

struct MultiUnitConverterView: View {
    @State private var inputValue: Double = 1.0
    @State private var inputUnit: UnitLength = .meters
    
    private let outputUnits: [UnitLength] = [
        .centimeters, .feet, .inches, .kilometers, .miles, .yards
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // 입력
                HStack {
                    TextField("값", value: $inputValue, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("단위", selection: $inputUnit) {
                        Text("미터").tag(UnitLength.meters)
                        Text("센티미터").tag(UnitLength.centimeters)
                        Text("피트").tag(UnitLength.feet)
                        Text("인치").tag(UnitLength.inches)
                    }
                }
                .padding()
                
                // 모든 단위로 변환 결과
                List(outputUnits, id: \.self) { unit in
                    let measurement = Measurement(value: inputValue, unit: inputUnit)
                    let converted = measurement.converted(to: unit)
                    
                    HStack {
                        Text(localizedUnitName(for: unit))
                        Spacer()
                        Text(formatted(measurement: converted))
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("다중 단위 변환")
        }
    }
    
    private func localizedUnitName(for unit: UnitLength) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        return formatter.string(from: unit)
    }
    
    private func formatted(measurement: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 3
        return formatter.string(from: measurement)
    }
}

#Preview {
    MultiUnitConverterView()
}
