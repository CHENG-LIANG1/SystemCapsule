//
//  SingleInfoView.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/14.
//

import SwiftUI

struct SingleInfoView: View {
    var body: some View {
        GeometryReader { geo in
                        VStack{
                            Image(systemName: "battery.100")
                            
                        }
                       .frame(width: geo.size.width, height: geo.size.height)
                   
               }
    }
}

struct SingleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SingleInfoView()
    }
}
