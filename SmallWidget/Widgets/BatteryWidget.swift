//
//  BatteryWidget.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/18.
//

import SwiftUI
import DeviceKit
import WidgetKit

struct BatteryWidget: View {
    @State private var batteryColor = Color.green
    @State private var batteryImage = "battery.100"
    @State private var batteryLevel = 0
    
    let device = Device.current
    
    func getImageName(){
        if(device.batteryState!.lowPowerMode){
            batteryColor = Color.yellow
        }else{
            batteryColor = Color.green
        }
        
//        if batteryLevel <= 10 {
//            batteryImage = "battery.0"
//        }else if batteryLevel <= 25 {
//            batteryImage = "battery.25"
//        }else if batteryLevel <= 50 {
//            batteryImage = "battery.50"
//        }else if batteryLevel <= 75 {
//            batteryImage = "battery.75"
//        }else if batteryLevel <= 100{
//            batteryImage = "battery.100"
//        }
        
        
        batteryLevel = [1,4,67,8,9,0].shuffled()[0]
    }
    
    var body: some View {
        VStack{
            Image(systemName: batteryImage)
                .font(.system(size: 64))
                .foregroundColor(batteryColor)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text("\(batteryLevel) %")
                .font(.system(size: 15, weight: .semibold, design: .rounded ))
                .foregroundColor(Color.black)
        }.onAppear {
//            batteryLevel = device.batteryLevel!
            _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
                getImageName()
                WidgetCenter.shared.reloadAllTimelines()
             })
        }
    }
}

//struct BatteryWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        BatteryWidget()
//    }
//}
