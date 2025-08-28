//
//  UnitSystemSelectorView.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import SwiftUI

struct UnitSystemSelectorView: View {
    @Environment(\.unitSystem) private var unitSystem
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 단위 시스템 선택 버튼
                Button(action: { showSheet = true }) {
                    Text("현재 단위 시스템: \(unitSystem.wrappedValue == .metric ? "미터법 (Metric)" : "야드·파운드법 (Imperial)")")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showSheet) {
                    VStack(spacing: 20) {
                        Text("단위 시스템 선택")
                            .font(.title2)
                            .padding(.top)
                        
                        Button("미터법 (Metric)") {
                            unitSystem.wrappedValue = .metric
                            showSheet = false
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("야드·파운드법 (Imperial)") {
                            unitSystem.wrappedValue = .imperial
                            showSheet = false
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                    }
                    .presentationDetents([.fraction(0.3)])
                }
                
                // 변환 예시 - 길이
                VStack(alignment: .leading, spacing: 12) {
                    Text("📏 길이 변환 예시")
                        .font(.headline)
                    
                    if unitSystem.wrappedValue == .metric {
                        let kmToMi = Measurement(value: 1, unit: UnitLength.kilometers).converted(to: .miles)
                        let cmToIn = Measurement(value: 100, unit: UnitLength.centimeters).converted(to: .inches)
                        Text("1 km = \(kmToMi.value, specifier: "%.2f") mi")
                        Text("100 cm = \(cmToIn.value, specifier: "%.2f") in")
                    } else {
                        let miToKm = Measurement(value: 1, unit: UnitLength.miles).converted(to: .kilometers)
                        let inToCm = Measurement(value: 10, unit: UnitLength.inches).converted(to: .centimeters)
                        Text("1 mi = \(miToKm.value, specifier: "%.2f") km")
                        Text("10 in = \(inToCm.value, specifier: "%.2f") cm")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 변환 예시 - 무게
                VStack(alignment: .leading, spacing: 12) {
                    Text("⚖️ 무게 변환 예시")
                        .font(.headline)
                    
                    if unitSystem.wrappedValue == .metric {
                        let kgToLb = Measurement(value: 1, unit: UnitMass.kilograms).converted(to: .pounds)
                        Text("1 kg = \(kgToLb.value, specifier: "%.2f") lb")
                    } else {
                        let lbToKg = Measurement(value: 1, unit: UnitMass.pounds).converted(to: .kilograms)
                        Text("1 lb = \(lbToKg.value, specifier: "%.2f") kg")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("단위 설정")
        }
    }
}

#Preview {
    UnitSystemSelectorView()
}
