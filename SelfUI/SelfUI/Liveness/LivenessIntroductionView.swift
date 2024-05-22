//
//  LivenessIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

struct LivenessIntroductionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                
            }
            .frame(height: 100)
            .background(.white)
            
            // stepped progress view
            ZStack() {
                SteppedProgressView(totalSteps: 5, currentStep: 1, progressColor: .green, backgroundColor: .gray)
            }
            .frame(height: 50, alignment: .leading)
            .offset(x: 20)
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Take a selfie".localized)
                    .font(.system(size: 36).weight(.bold))
                    .foregroundColor(.black)
                Text("Take a selfie description".localized)
                    .font(.appFont(fontName: .sfPro, size: 17).weight(.bold))
                    .lineSpacing(1.18)
                    .foregroundColor(.black)
            }
            .padding(EdgeInsets(top: 100, leading: 15, bottom: 10, trailing: 15))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    ButtonView()
                    BrandView()
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
                .frame(height: 104)
                .background(.white)
                VStack(spacing: 10) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 140, height: 5)
                        .background(Color(red: 0.58, green: 0.58, blue: 0.58))
                        .cornerRadius(20)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 10))
                .frame(width: 393, height: 34)
                .background(.white)
            }
            .frame(height: 138 + 32)
        }
        .frame(width: 393, height: 853);
    }
}

struct ContentViewView_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(["en", "de"], id: \.self) { id in
            LivenessIntroductionView()
                .environment(\.locale, .init(identifier: id))
        }
    }
}
