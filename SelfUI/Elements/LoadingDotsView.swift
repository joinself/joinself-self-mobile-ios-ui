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

struct LoadingDotsView: View {
    @State private var activeIndex = 0
    let animationDelay = 0.3
    let colors: [Color] = [.defaultBlue, .defaultPink, .defaultYellow, .defaultGreen]
    @ObservedObject var viewModel = LoadingDotsViewModel()
    
    public init() {
        
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<viewModel.numberOfDots, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(colors[index])
                    .opacity(self.activeIndex == index ? 1 : 0.3)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: Double(index) * animationDelay)
            }
        }
        .onAppear {
            self.activeIndex = 1
            Timer.scheduledTimer(withTimeInterval: animationDelay, repeats: true) { timer in
                self.activeIndex = (self.activeIndex + 1) % viewModel.numberOfDots
            }
        }
    }
}

#Preview {
    LoadingDotsView()
}
