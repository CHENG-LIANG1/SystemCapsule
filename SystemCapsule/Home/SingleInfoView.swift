//
//  SingleInfoView.swift
//  SystemCapsule
//
//  Created by Cheng Liang(Louis) on 2022/9/14.
//

import SwiftUI

struct SingleInfoView: View {
    var imageName: String
    var description: String
    var symbolColor: Color
    var body: some View {
        VStack{
            Image(systemName: imageName)
                .font(.system(size: 64))
                .foregroundColor(symbolColor)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text(description)
                .font(.custom(K.roundedFont, size: 16))
                .foregroundColor(Color.BackgroundColor)
        }
    }
}

struct MultipleInfoView: View {
    
    var body: some View {
        HStack {
            
        }
    }
}



struct SingleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SingleInfoView(imageName: "battery.100", description: "70% Charged", symbolColor: Color.green)
    }
}
