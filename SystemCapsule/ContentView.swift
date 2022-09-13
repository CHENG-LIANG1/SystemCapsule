//
//  ContentView.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Device", systemImage: "iphone.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
