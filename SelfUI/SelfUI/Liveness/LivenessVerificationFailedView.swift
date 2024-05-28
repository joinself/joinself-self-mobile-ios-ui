//
//  LivenessVerificationFailedView.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

public struct LivenessVerificationFailedView: View {
    @ObservedObject var viewModel = LivenessVerificationViewModel()
    
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    
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
                                    onNavigationBack()
                                }
                        }
                        .frame(width: 44, height: 32)
                    }
                }
                .frame(width: 393, height: 100)
                .background(.white)
                
                
                // stepped progress view
                ZStack(alignment: .center) {
                    SteppedProgressView(totalSteps: 5, currentStep: 1, progressColor: Color(red: 0, green: 0.64, blue: 0.43), backgroundColor: .gray)
                        .padding(.leading, 30)
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Verification failed".localized)
                        .font(.system(size: 36).weight(.bold))
                        .foregroundColor(.black)
                    Text(viewModel.bodyString)
                        .font(Font.system(size: 36).weight(.bold))
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
                        ButtonView()
                    })
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .padding()
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    LivenessVerificationFailedView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}
