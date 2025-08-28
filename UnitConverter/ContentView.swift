//
//  ContentView.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var unitSystem: UnitSystem = .metric
    
    var body: some View {
        TabView {
            UnitConverterView()
                .tabItem {
                    Label("단일 변환", systemImage: "arrow.left.arrow.right")
                }
            
            MultiUnitConverterView()
                .tabItem {
                    Label("다중 변환", systemImage: "square.grid.2x2")
                }
            
            UnitSystemSelectorView()
                .tabItem {
                    Label("단위 설정", systemImage: "gearshape")
                }
        }
        .environment(\.unitSystem, $unitSystem)
    }
}


#Preview {
    ContentView()
}
