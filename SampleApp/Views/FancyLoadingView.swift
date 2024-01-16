//
//  LaunchScreen.swift
//  SampleApp
//
//  Created by Nathan Lambson on 1/15/24.
//

import SwiftUI

struct FancyLoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            backgroundView
            GeometryReader { geometry in
                animatedCircles(geometry: geometry)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
    
    private var backgroundView: some View {
        Image("background") // Your background image
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
    
    private func animatedCircles(geometry: GeometryProxy) -> some View {
        ZStack {
            ForEach(0..<5) { index in
                circleView(index: index, scale: (isAnimating ? 0.2 : 1.0) + CGFloat(index) / 5, geometry: geometry)
                circleView(index: index, scale: (isAnimating ? 0.4 : 1.0) - CGFloat(index) / 5, geometry: geometry)
            }
        }
        .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the animation
        .animation(
            Animation
                .linear(duration: 2.0)
                .repeatForever(autoreverses: false),
            value: isAnimating
        )
    }
    
    private func circleView(index: Int, scale: CGFloat, geometry: GeometryProxy) -> some View {
        let indexAsCGFloat = CGFloat(index)
        
        return Circle()
            .frame(width: geometry.size.width / 10, height: geometry.size.width / 10) // Adjust size as needed
            .scaleEffect(scale)
            .foregroundColor(Color.white.opacity(1.0 - indexAsCGFloat / 5))
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                Animation
                    .linear(duration: 2.0)
                    .repeatForever(autoreverses: false)
                    .delay(Double(index) * 0.2),
                value: isAnimating
            )
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        FancyLoadingView()
    }
}
