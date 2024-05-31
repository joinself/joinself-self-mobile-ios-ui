//
//   SelectDocumentView.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

public struct  SelectDocumentView: View {
    
    public var onSelect: ((_ documentType: DocumentType) -> Void)?
    
    public init(onSelect: ((_ documentType: DocumentType) -> Void)? = nil) {
        self.onSelect = onSelect
    }
    
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
                                    onSelect?(.none)
                                }
                        }
                        .onTapGesture {
                            onSelect?(.none)
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
                    Text("title_document_selection".localized)
                        .font(.system(size: 36).weight(.bold))
                        .foregroundColor(.black)
                    Text("detail_document_selection".localized)
                        .font(Font.custom("Barlow-Regular", size: 17).weight(.regular))
                      .lineSpacing(1.14)
                      .foregroundColor(.black)
                    Spacer()
                }
                .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                VStack(spacing: 12) {
                    ButtonView(title: "Passport".localized) {
                        onSelect?(.passport)
                    }
                    
                    ButtonView(title: "Identity document".localized, backgroundColor: .defaultBlue) {
                        onSelect?(.identityCard)
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
    SelectDocumentView()
}
