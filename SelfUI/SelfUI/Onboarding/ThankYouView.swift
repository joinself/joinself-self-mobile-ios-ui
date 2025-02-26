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
    
    let buttonColor: Color
    
    var onGetStarted: (() -> Void)?
    init(buttonColor: Color = .defaultPink, onGetStarted: (() -> Void)? = nil) {
        self.buttonColor = buttonColor
        self.onGetStarted = onGetStarted
    }
    
    public var body: some View {
        BaseView {
            VStack(alignment: .leading, spacing: 0) {
                Text("onboarding_thankyou_title".localized)
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Spacer()
            }
            
            VStack (spacing: 0){
                Text(self.cal())
                    .modifier(Body1TextStyle())
                    .tint(.defaultBlue) // link color
                    .multilineTextAlignment(.center)
            }
            
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
                ButtonView(title: "button_joinself".localized, backgroundColor: self.buttonColor) {
                    onGetStarted?()
                }
            } else {
                ButtonView(title: "button_joinself".localized, backgroundColor: .defaultGray) {
                    onGetStarted?()
                }
            }
        }
    }
    
    private func cal() -> AttributedString {
        let str = "\("To join Self, please agree to our".localized)\n[terms & conditions](https://docs.joinself.com/agreements/consumer_terms_and_conditions) & [privacy policy](https://docs.joinself.com/agreements/app_privacy_notice)."
        var markdownText = try! AttributedString(markdown: str, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace))
        let termAndConditionLink = markdownText.range(of: "terms & conditions")!
        markdownText[termAndConditionLink].underlineStyle = .single
        
        let privacyPolicyLink = markdownText.range(of: "privacy policy")!
        markdownText[privacyPolicyLink].underlineStyle = .single
        
        return markdownText
    }
}

#Preview {
    ThankYouView(buttonColor: .defaultGreen)
}
