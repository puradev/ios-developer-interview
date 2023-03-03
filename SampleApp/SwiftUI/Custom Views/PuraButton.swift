//
//  PuraButton.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import SwiftUI


struct PuraButton: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Text(title)
            .frame(width: width, height: height)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold))
            .cornerRadius(10)
    }
}
