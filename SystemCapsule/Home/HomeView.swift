//
//  HomeView.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/13.
//

import SwiftUI
import DeviceKit
import WidgetKit


struct HomeView: View {
    
    @State private var batteryLevel = 0
    
    let device = Device.current
    
    let smallWidth = (K.screenWidth - 72) / 2
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    @State private var batteryColor = Color.green
    @State private var batteryImage = "battery.100"
    
    @State private var text = ""
    
    var ToggleThemeView: some View {
        Toggle("Dark Mode", isOn: $isDarkModeOn)
            .onChange(of: isDarkModeOn) { (state)  in
                changeDarkMode(state: state)
            }.labelsHidden()
            .tint(Color.TextColorPrimary)
    }
    

    var body: some View {
        NavigationView {
            ZStack {
                Color.BackgroundColor.edgesIgnoringSafeArea(.all)
                VStack() {

                    ToggleThemeView
                    
                    ScrollView {
                        
                        HStack(alignment: .center, spacing: 24) {
                            SingleInfoView(imageName: batteryImage, description: "\(batteryLevel)% Charged", symbolColor: batteryColor)
                                .frame(width: smallWidth, height: smallWidth)
                                .background(Color.TextColorPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
                    
                            
                            SingleInfoView(imageName: batteryImage, description: "\(batteryLevel)% Charged", symbolColor: batteryColor)
                                .frame(width: smallWidth, height: smallWidth)
                                .background(Color.TextColorPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .circular))
       
                        }
                        
                        
                    
                        
                        TextField("", text: $text)

                            .modifier(PlaceholderStyle(showPlaceHolder: text.isEmpty,
                                                       placeholder: "Enter Something", forgroundColor: Color.black))
                            .modifier(
                                
                                gradientTextFieldModifier(radius: 15, startColor: Color.TextColorPrimary, endColor: Color.TextColorPrimary , textColor: Color.BackgroundColor, textSize: 18)

                            )

                        
                            .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
                            .onSubmit {
    
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                

                                if(text.isEmpty){ return}
                                
                                UserDefaultsUtils().setWidgetText(text: text)
                                
                                WidgetCenter.shared.reloadAllTimelines()
    
                            }
                       

                    }
                    
                    
                    
                }
                .background(Color.BackgroundColor)
                .font(Font.custom("Baloo-Regular", size: 20))
                .navigationBarTitle("Dashboard", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .foregroundColor(Color.BackgroundColor)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
            }
        }
        .background(Color.BackgroundColor)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            setAppTheme()
            batteryLevel = device.batteryLevel!
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                getImageName()
             })
        })
    }
    
    func setAppTheme(){
      //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: isDarkModeOn)
        
        
      //MARK: or use device theme
//      if (colorScheme == .dark)
//      {
//        isDarkModeOn = true
//      }
//      else{
//        isDarkModeOn = false
//      }
//      changeDarkMode(state: isDarkModeOn)
    }
    
    func getLowPowerColor() -> Color{
        return device.batteryState!.lowPowerMode ? Color.yellow : Color.green
    }
    

    func changeDarkMode(state: Bool){
      (UIApplication.shared.connectedScenes.first as?
      UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
      UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    func getImageName(){
        if(device.batteryState!.lowPowerMode){
            batteryColor = Color.yellow
        }else{
            batteryColor = Color.green
        }
        
        if device.batteryState == .charging(batteryLevel){
            batteryImage = "battery.100.bolt"
        }else{
            if batteryLevel <= 10 {
                batteryImage = "battery.0"
            }else if batteryLevel <= 25 {
                batteryImage = "battery.25"
            }else if batteryLevel <= 50 {
                batteryImage = "battery.50"
            }else if batteryLevel <= 75 {
                batteryImage = "battery.75"
            }else if batteryLevel <= 100{
                batteryImage = "battery.100"
            }
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
