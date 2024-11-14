//
//  PassportStartScanView.swift
//  SelfUI
//
//  Created by Long Pham on 31/5/24.
//

import SwiftUI

public struct PassportStartScanView: View {
     
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigationBack
        Utils.instance.applyDefaultFonts()
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
                                    print("onNavigateBack")
                                    onNavigateBack()
                                }
                        }
                        .frame(width: 44, height: 32)
                    }
                }
                .frame(width: 393, height: 100)
                .background(.white)
                
                CustomProgressView(steps: [
                    Step(title: "1", state: .done),
                    Step(title: "2", state: .active),
                    Step(title: "3", state: .inactive),
                    Step(title: "4", state: .inactive),
                    Step(title: "5", state: .inactive)
                ])
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("title_start_scan_passport".localized)
                        .font(.defaultH3.weight(.bold))
                        .foregroundColor(.black)
                    
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 361, height: 327)
                      .background {
                          GIFView(gifName: "start_scan")
                              .frame(width: 361, height: 327)
                            .scaleEffect(x: 0.8, y: 0.8)
                            .clipped()
                      }
                }
                .padding(EdgeInsets(top: 20, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 12) {
                    ButtonView(title: "Start scan".localized) {
                        onGettingStarted()
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
    PassportStartScanView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}
