//
//  UserDefaultsUtils.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/14.
//

import Foundation


class UserDefaultsUtils {
    static var shared = UserDefaultsUtils()
    
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Constants.DARK_MODE)
    }

    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
    

    func setWidgetText(text: String){
        let userDefualts = UserDefaults(suiteName: "group.smallWidgetCache")
        userDefualts?.setValue(text, forKey: Constants.WIDGET_TEXT)
    }
    
    func setWidgetImage(text: String){
        let userDefualts = UserDefaults(suiteName: "group.smallWidgetCache")
        userDefualts?.setValue(text, forKey: Constants.WIDGET_TEXT)
            
    }
   
}
