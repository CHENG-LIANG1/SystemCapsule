//
//  SettingsView.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/15.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                    .listRowSeparator(.hidden)
                Text("Static row 2")
                    .listRowSeparator(.hidden)
            }

            Section("Section 2"){
                ForEach(0..<5){
                    Text("Dynamic row \($0)")
                        .listRowSeparator(.hidden)
                }
            }
            
            Section("Section 1") {
                Text("Static row 3")
                    .listRowSeparator(.hidden)
                Text("Static row 4")
                    .listRowSeparator(.hidden)
            }
            Section("Section 1") {
                Text("Static row 3")
                    .listRowSeparator(.hidden)
                Text("Static row 4")
                    .listRowSeparator(.hidden)
            }
            Section("Section 1") {
                Text("Static row 3")
                    .listRowSeparator(.hidden)
                Text("Static row 4")
                    .listRowSeparator(.hidden)
            }
            Section("Section 1") {
                Text("Static row 3")
                    .listRowSeparator(.hidden)
                Text("Static row 4")
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.automatic)
       
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
