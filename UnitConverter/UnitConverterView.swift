//
//  UnitConverterView.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import SwiftUI

struct UnitConverterView: View {
    @StateObject private var viewModel = UnitConverterViewModel()
    @Environment(\.unitSystem) private var unitSystem
    
    // 미터법/야드파운드 단위 목록
    private var lengthUnits: [UnitLength] {
        switch unitSystem.wrappedValue {
        case .metric:
            return [.meters, .centimeters, .millimeters, .kilometers]
        case .imperial:
            return [.feet, .inches, .yards, .miles]
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 입력
                VStack(alignment: .leading) {
                    Text("변환할 값")
                        .font(.headline)
                    
                    HStack {
                        TextField("값 입력", text: $viewModel.inputValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
                        Picker("입력 단위", selection: $viewModel.selectedInputUnit) {
                            ForEach(lengthUnits, id: \.self) { unit in
                                Text(localizedUnitName(for: unit)).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Image(systemName: "arrow.down")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                // 출력
                VStack(alignment: .leading) {
                    Text("변환 결과")
                        .font(.headline)
                    
                    HStack {
                        Text(viewModel.result.isEmpty ? "결과가 여기에 표시됩니다" : viewModel.result)
                            .foregroundColor(viewModel.result.isEmpty ? .gray : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        Picker("출력 단위", selection: $viewModel.selectedOutputUnit) {
                            ForEach(lengthUnits, id: \.self) { unit in
                                Text(localizedUnitName(for: unit)).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Button("변환하기") {
                    viewModel.convert()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.inputValue.isEmpty)
                
                Spacer()
            }
            .padding()
            .navigationTitle("단위 변환기")
            .onChange(of: viewModel.inputValue) { _, _ in autoConvert() }
            .onChange(of: viewModel.selectedInputUnit) { _, _ in autoConvert() }
            .onChange(of: viewModel.selectedOutputUnit) { _, _ in autoConvert() }
            .onChange(of: unitSystem.wrappedValue) { _, _ in
                // 단위 시스템 변경 시 단위 초기화
                if let first = lengthUnits.first, let last = lengthUnits.last {
                    viewModel.selectedInputUnit = first
                    viewModel.selectedOutputUnit = last
                }
                autoConvert()
            }
        }
    }
    
    private func autoConvert() {
        if !viewModel.inputValue.isEmpty {
            viewModel.convert()
        }
    }
    
    private func localizedUnitName(for unit: UnitLength) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        return formatter.string(from: unit)
    }
}

#Preview {
    UnitConverterView()
}
