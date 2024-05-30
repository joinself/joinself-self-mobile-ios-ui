//
//  PassportIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct PassportIntroductionView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    
    public var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(spacing: 10) {
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                    HStack {
                        VStack (alignment: .leading) {
                            Image("ic_back_dark", bundle: mainBundle) // Replace with your image name
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 15))
                                .onTapGesture {
                                    print("onNavigationBack")
                                    onNavigateBack()
                                }
                        }
                        .onTapGesture {
                            onNavigateBack()
                        }
                        .frame(width: 44, height: 32)
                        .padding(.leading, 15)
                    }
                }
                .frame(width: 393, height: 100)
                .background(.white)
                
                
                // stepped progress view
                ZStack(alignment: .center) {
                    SteppedProgressView(totalSteps: 5, currentStep: 1)
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Passport verification preparation".localized)
                        .font(.system(size: 36).weight(.bold))
                        .foregroundColor(.black)
                    Text("Passport verification preparation body".localized)
                        .font(Font.custom("Barlow-Regular", size: 17).weight(.regular))
                      .lineSpacing(1.14)
                      .foregroundColor(.black)
                    Spacer()
                }
                .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                VStack(spacing: 12) {
                    Button(action: {
                        onGettingStarted()
                    }, label: {
                        ButtonView(title: "Start".localized)
                    })
                    
                    OutlinedButton(title: "i don’t have a passport") {
                        // TODO: I dont have a passport
                    }
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .padding()
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    PassportIntroductionView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
