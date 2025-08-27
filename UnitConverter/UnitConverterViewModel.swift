//
//  UnitConverterViewModel.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import Foundation

class UnitConverterViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var selectedInputUnit: UnitLength = .meters
    @Published var selectedOutputUnit: UnitLength = .feet
    @Published var result: String = ""
    
    private let formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func convert() {
        guard let value = Double(inputValue) else {
            result = "잘못된 입력값"
            return
        }
        
        let inputMeasurement = Measurement(value: value, unit: selectedInputUnit)
        let outputMeasurement = inputMeasurement.converted(to: selectedOutputUnit)
        
        result = formatter.string(from: outputMeasurement)
    }
}
