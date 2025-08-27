//
//  UnitConverterView.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import SwiftUI

struct UnitConverterView: View {
    @StateObject private var viewModel = UnitConverterViewModel()
    
    // 지원하는 길이 단위들
    private let lengthUnits: [UnitLength] = [
        .meters, .centimeters, .millimeters, .kilometers,
        .feet, .inches, .yards, .miles
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 입력 섹션
                VStack(alignment: .leading) {
                    Text("변환할 값")
                        .font(.headline)
                    
                    HStack {
                        TextField("값 입력", text: $viewModel.inputValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
                        Picker("입력 단위", selection: $viewModel.selectedInputUnit) {
                            ForEach(lengthUnits, id: \.self) { unit in
                                Text(localizedUnitName(for: unit))
                                    .tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                // 변환 화살표
                Image(systemName: "arrow.down")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                // 출력 섹션
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
                                Text(localizedUnitName(for: unit))
                                    .tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                // 변환 버튼
                Button("변환하기") {
                    viewModel.convert()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.inputValue.isEmpty)
                
                Spacer()
            }
            .padding()
            .navigationTitle("단위 변환기")
            .onChange(of: viewModel.inputValue) { _, _ in
                if !viewModel.inputValue.isEmpty {
                    viewModel.convert()
                }
            }
            .onChange(of: viewModel.selectedInputUnit) { _, _ in
                if !viewModel.inputValue.isEmpty {
                    viewModel.convert()
                }
            }
            .onChange(of: viewModel.selectedOutputUnit) { _, _ in
                if !viewModel.inputValue.isEmpty {
                    viewModel.convert()
                }
            }
        }
    }
    
    // 지역화된 단위 이름 반환
    private func localizedUnitName(for unit: UnitLength) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .long
        return formatter.string(from: unit)
    }
}

#Preview {
    UnitConverterView()
}
