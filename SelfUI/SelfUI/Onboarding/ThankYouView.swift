//
//  ThankYouView.swift
//  SelfUI
//
//  Created by Long Pham on 29/7/24.
//

import SwiftUI

struct ThankYouView: View {
    @State private var isOn = false
    @Environment(\.presentationMode) var presentationMode
    
    var onGetStarted: (() -> Void)?
    init(onGetStarted: (() -> Void)? = nil) {
        self.onGetStarted = onGetStarted
    }
    
    public var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 100)
                VStack(alignment: .leading, spacing: 0) {
                    Text("onboarding_thankyou_title".localized)
                        .font(.defaultTitle)
                        .foregroundColor(.black)
                    Spacer()
                }.padding()
                Spacer()
                VStack(spacing: 12) {
                    VStack (spacing: 0){
                        Text("To join Self, please agree to our".localized)
                            .foregroundStyle(.black)
                        HStack (spacing: -4) {
                            Text("terms & conditions".localized)
                                .foregroundColor(.defaultBlue)
                                .onTapGesture {
                                    // TODO: Open term and conditions
                                    print("Click term & conditions")
                                }
                            Text("&").globalBodyTextStyle()
                            Text("privacy policy.")
                                .foregroundColor(.defaultBlue)
                                .onTapGesture {
                                    // TODO: Open privacy policy
                                    print("Click privacy policy")
                                }
                        }.frame(height: 24)
                    }.padding(0)
                    
                    HStack (alignment: .center) {
                        Toggle("", isOn: $isOn)
                            .toggleStyle(CustomToggleStyle(onColor: .toggleOn, offColor: .toggleOff, thumbColor: .white))
                            .frame(maxWidth: 40)
                            .padding()
                        Text("i_agree".localized)
                            .globalBodyTextStyle()
                            .onTapGesture {
                                isOn.toggle()
                            }
                    }
                    
                    if isOn {
                        ButtonView(title: "button_joinself".localized, backgroundColor: .defaultPink) {
                            onGetStarted?()
                        }
                    } else {
                        ButtonView(title: "button_joinself".localized, backgroundColor: .defaultGray) {
                            onGetStarted?()
                        }
                    }
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .padding()
            .ignoresSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image("ic_back_dark", bundle: mainBundle)
                    }
                }
            }
        }
    }
}

#Preview {
    ThankYouView()
}
