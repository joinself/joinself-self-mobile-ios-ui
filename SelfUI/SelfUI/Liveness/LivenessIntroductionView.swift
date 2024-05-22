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
                    .font(.appFont(fontName: .barlow, size: 36, weight: .bold).weight(.bold))
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
                    HStack(spacing: 10) {
                        Text("start")
                            .font(Font.custom("Barlow", size: 17).weight(.bold))
                            .tracking(0.85)
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
                    .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                    .background(Color(red: 0, green: 0.64, blue: 0.43))
                    .cornerRadius(40)
                    HStack(spacing: 10) {
                        Text("Powered by")
                            .font(Font.custom("Barlow", size: 15).weight(.medium))
                            .lineSpacing(22)
                            .foregroundColor(.black)
                        ZStack() {
                            ZStack() { }
                                .frame(width: 17.94, height: 10.94)
                                .offset(x: 0.04, y: 0.04)
                        }
                        .frame(width: 30, height: 30)
                    }
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
            .frame(height: 138)
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
