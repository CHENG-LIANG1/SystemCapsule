//
//  HomeView.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/13.
//

import SwiftUI
import DeviceKit

struct HomeView: View {
    
    @State private var batteryLevel = 0
    
    let device = Device.current
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("batteryLevel: \(batteryLevel)")
        }
        .padding()
        .onAppear{
            batteryLevel = device.batteryLevel!
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
