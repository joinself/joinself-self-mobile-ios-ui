//
//  LoadingDotsView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

class LoadingDotsViewModel: ObservableObject {
    @Published var numberOfDots: Int = 4
}

struct LoadingIndicatorView: View {
    @State private var scales: [CGFloat] = []
    let dotCount = 4
    let minScale: CGFloat = 0.5
    let animationDuration: Double = 0.5
    let delayUnit: Double = 0.2
    let isBlack: Bool
    let dotSize: CGFloat
    let colors: [Color]

    init(isBlack: Bool = false, dotSize: CGFloat = 20) {
        self.isBlack = isBlack
        self.dotSize = dotSize

        self.colors = isBlack
        ? [Color.backgroundSecondary, .backgroundSecondary, .backgroundSecondary, .backgroundSecondary]
        : [.defaultBlue, .defaultPink, .defaultYellow, .defaultGreen]
    }

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(scales.indices.contains(index) ? scales[index] : minScale)
                    .foregroundColor(colors[index % colors.count])
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        scales = Array(repeating: minScale, count: dotCount)
        
        for i in 0..<dotCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * delayUnit) {
                withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: true)) {
                    scales[i] = 1.0
                }
            }
        }
    }
}

struct DotsAnimationView: View {
    var body: some View {
        LoadingIndicatorView(isBlack: false, dotSize: 20)
        LoadingIndicatorView(isBlack: false, dotSize: 20)
            .frame(width: 100)
            .padding()
    }
}

struct LoadingDotsView: View {
//    @State private var activeIndex = 0
//    let animationDelay = 0.6
//    let colors: [Color] = [.defaultBlue, .defaultPink, .defaultYellow, .defaultGreen]
//    private let opacityStart: Double = 1.0
//    private let opacityEnd: Double = 1.0
//    private let widthStart: CGFloat = 20
//    private let widthEnd: CGFloat = 10
//    @ObservedObject private var viewModel = LoadingDotsViewModel()
//    
    public init() {
        
    }
    
    var body: some View {
        LoadingIndicatorView(isBlack: false, dotSize: 20)
//        HStack(spacing: 10) {
//            Spacer()
//            ForEach(0..<viewModel.numberOfDots, id: \.self) { index in
//                Circle()
//                    .frame(width: self.activeIndex == index ? widthStart : widthEnd, height: self.activeIndex == index ? widthStart : widthEnd)
//                
//                    .foregroundColor(colors[index])
//                    .opacity(self.activeIndex == index ? opacityStart : opacityEnd)
//                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: Double(index) * animationDelay)
//            }
//            Spacer()
//        }
//        .onAppear {
//            self.activeIndex = 1
//            Timer.scheduledTimer(withTimeInterval: animationDelay, repeats: true) { timer in
//                self.activeIndex = (self.activeIndex + 1) % viewModel.numberOfDots
//            }
//        }
    }
}

#Preview {
    VStack {
        LoadingDotsView()
        DotsAnimationView()
        LoadingIndicatorView(isBlack: false, dotSize: 20)
        LoadingIndicatorView(isBlack: true, dotSize: 20)
    }
}
