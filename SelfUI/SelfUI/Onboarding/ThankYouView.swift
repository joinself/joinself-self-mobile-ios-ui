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
                    Text("To join Self, please agree to our")
                        .foregroundStyle(.black)
                    HStack {
                        Text("terms & conditions")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                // TODO: Open term and conditions
                                print("Click term & conditions")
                            }
                        Text("&").globalBodyTextStyle()
                        Text("privacy policy.")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                // TODO: Open privacy policy
                                print("Click privacy policy")
                            }
                    }
                    
                    HStack (alignment: .center) {
                        Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: .defaultGreen))
                        .frame(maxWidth: 40)
                        .padding()
                        Text("i_agree".localized)
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
