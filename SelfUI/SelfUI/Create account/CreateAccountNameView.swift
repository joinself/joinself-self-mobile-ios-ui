//
//  CreateAccountNameView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct CreateAccountNameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var isValid: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    public init(onEnteredName: ((String) -> Void)? = nil) {
        self.onEnteredName = onEnteredName
    }
    
    var onEnteredName: ((String) -> Void)?
    
    public var body: some View {
        VStack {
            ScrollView {
                VStack {
                    // stepped progress view
                    CustomProgressView(steps: [
                        Step(title: "1", state: .done),
                        Step(title: "2", state: .done),
                        Step(title: "3", state: .done),
                        Step(title: "4", state: .done),
                        Step(title: "5", state: .active)
                    ]).frame(minHeight: 100)
                    
        //            Spacer()
                    VStack(alignment: .leading, spacing: 30) {
                        Text("create_account_name_title".localized)
                            .font(.defaultTitle)
                            .foregroundColor(.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                        
                        OutlinedTextField(boxLabel: "enter_name_label".localized, placeHolder: "enter_name_placeholder".localized, boxErrorDescription: "enter_name_error".localized, text: $name, isValid: $isValid, isFocused: _isTextFieldFocused)
                            .onChange(of: name) { newValue in
                                isValid = newValue.count > 0
                            }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
    //                Spacer()
    //                VStack(spacing: 12) {
    //                    ButtonView(title: "button_confirm_name".localized,backgroundColor: isValid ? .defaultGreen : .defaultDark) {
    //                        onEnteredName?(name)
    //                    }.disabled(!isValid)
    //
    //                    BrandView(isDarked: true)
    //                }.padding()
                }
                .onTapGesture {
                    print("Dismiss keyboard")
                    isTextFieldFocused = false
                }
                
            }
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_confirm_name".localized,backgroundColor: isValid ? .defaultGreen : .defaultDark) {
                    onEnteredName?(name)
                }.disabled(!isValid)
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    NavBackButton()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateAccountNameView()
    }
}
