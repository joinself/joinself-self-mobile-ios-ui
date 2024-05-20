//
//  LivenessView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

public struct LivenessView: View {
    @State private var imageName = "bg_turn_left"
    @State private var text = "Look right and back"
    
    public init () {}
    
    public var body: some View {
        ZStack {
            CameraOvelayView()
            VStack {
                Spacer()
//                TipsSelfie(tipImageName: self.tipImageName, tipDescription: self.text)
                ZStack {
                    Image(imageName, bundle: mainBundle)
                    Text(text)
                        .font(Font.custom("Barlow", size: 25).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: 0, y: 0)
                        .onTapGesture {
                            self.text = "ABC"
                        }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    public func onUpdate(text: String) {
        print("onUpdate: \(text)")
        self.text = text
        self.imageName = "bg_turn_right"
    }
}

#Preview {
    LivenessView()
}
