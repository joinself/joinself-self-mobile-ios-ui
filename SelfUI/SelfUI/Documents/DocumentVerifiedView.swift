//
//  DocumentVerifiedView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct DocumentVerifiedView: View {
    
    public init(onBack: (() -> Void)? = nil, onNext: (() -> Void)? = nil) {
        self.onBack = onBack
        self.onNext = onNext
    }
    
    var onNext: (() -> Void)?
    var onBack: (() -> Void)?
    
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
                                    onBack?()
                                }
                        }
                        .onTapGesture {
                            onBack?()
                        }
                        .frame(width: 44, height: 32)
                        .padding(.leading, 15)
                    }
                }
                .frame(width: 393, height: 100)
                .background(.white)
                
                CustomProgressView(steps: [
                    Step(title: "1", state: .done),
                    Step(title: "2", state: .done),
                    Step(title: "3", state: .done),
                    Step(title: "4", state: .done),
                    Step(title: "5", state: .done)
                ])
                
                VStack(alignment: .leading) {
                    Text("msg_document_verified".localized)
                        .font(.defaultLargeTitle)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    Spacer()
                }.padding()
                
                Spacer()
                VStack(spacing: 12) {
                    ButtonView(title: "button_continue".localized) {
                        onNext?()
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
    DocumentVerifiedView()
}
