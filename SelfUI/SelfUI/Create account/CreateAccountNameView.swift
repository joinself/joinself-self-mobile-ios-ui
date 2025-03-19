//
//  CreateAccountNameView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public struct CreateAccountNameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var isValid: Bool = false
    @State private var editFieldState: OutlineTextFieldState = .initial
    @FocusState private var isTextFieldFocused: Bool
    
    public init(onEnteredName: ((String) -> Void)? = nil) {
        self.onEnteredName = onEnteredName
    }
    
    var onEnteredName: ((String) -> Void)?
    
    public var body: some View {
        BaseProgressView (enableBackNavigation: false, totalSteps: 5, activeStep: 5){
            ScrollView {
                VStack (spacing: 30) {
                    Text("create_account_name_title".localized)
                        .modifier(Heading3TextStyle())
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    OutlineLabelTextField(label: "enter_name_label".localized, placeHolder: "enter_name_placeholder".localized,
                                          errorDescription: "enter_name_error".localized,
                                          keyboardType: .default,
                                          textInputAutocapitalization: .words,
                                          state: $editFieldState, text: $name, isFocused: _isTextFieldFocused)
                }
                .onChange(of: name) { newValue in
                    isValid = newValue.count > 0
                    
                    editFieldState = isValid ? .valid : .error
                }
                Spacer()
                .onTapGesture {
                    print("Dismiss keyboard")
                    isTextFieldFocused = false
                }
            }
            
            ButtonView(title: "button_confirm_name".localized,backgroundColor: isValid ? .defaultGreen : .defaultDark) {
                onEnteredName?(name)
            }
            .disabled(!isValid)
            .frame(maxHeight: 44)
        }
    }
}

#Preview {
    NavigationStack {
        CreateAccountNameView()
    }
}
