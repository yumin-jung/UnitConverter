//
//  ContentView.swift
//  UnitConverter
//
//  Created by yumin on 8/28/25.
//

import SwiftUI

struct ContentView: View {
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
        }
    }
}

#Preview {
    ContentView()
}
