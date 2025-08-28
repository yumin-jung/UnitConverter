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
    @Environment(\.unitSystem) private var unitSystem
    
    // 출력 단위 (단위 시스템에 따라 변환)
    private var outputUnits: [UnitLength] {
        switch unitSystem.wrappedValue {
        case .metric:
            return [.kilometers, .centimeters, .millimeters]
        case .imperial:
            return [.miles, .feet, .inches, .yards]
        }
    }
    
    private var inputCandidates: [UnitLength] {
        switch unitSystem.wrappedValue {
        case .metric:
            return [.meters, .centimeters, .kilometers]
        case .imperial:
            return [.feet, .inches, .miles]
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 입력
                HStack {
                    TextField("값", value: $inputValue, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("단위", selection: $inputUnit) {
                        ForEach(inputCandidates, id: \.self) { unit in
                            Text(localizedUnitName(for: unit)).tag(unit)
                        }
                    }
                }
                .padding()
                
                // 변환 결과 리스트
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
            .onChange(of: unitSystem.wrappedValue) { _, _ in
                // 단위 시스템 바뀌면 입력 단위 초기화
                inputUnit = inputCandidates.first ?? .meters
            }
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
