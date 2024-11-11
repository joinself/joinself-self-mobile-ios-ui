//
//  PinCodeView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI
import UIKit

public struct PinCodeView: View {
    @Binding var pin: [String]
    @FocusState private var focusedField: Int?
    @State private var code: String = ""
    
    private let pinLength: Int
    private var onEnteredCode: ((_ code: String) -> Void)?
    public init(pinLength: Int = 6, pinCode: Binding<[String]> = .constant(Array(repeating: "", count: 6)), onEnteredCode: ((_ code: String) -> Void)? = nil) {
        self.pinLength = pinLength
        self.onEnteredCode = onEnteredCode
        self._pin = pinCode
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pinLength, id: \.self) { index in
                TextField("", text: $pin[index])
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .background(Color.defaultGray.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.defaultGrayscale)
                    .tag("\(index)")
                    .accentColor(.defaultBlack)
                    .overlay(
                        RoundedRectangle(cornerRadius: .defaultCornerRadius)
                            .inset(by: 0.5)
                            .stroke((focusedField == index) ? Color.defaultBlue : Color.defaultGray, lineWidth: 1)
                    )
                    .focused($focusedField, equals: index)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { notification in
                        if let textField = notification.object as? UITextField {
                            if let pastedText = textField.text, pastedText.count == pinLength {
                                if self.code == pastedText {
                                    print("Ignore update pin.")
                                    return
                                }
                                
                                self.code = pastedText
                                print("Text: \(pastedText)")
                                self.updatePin(pastedText)
                            }
                        }
                    }
                    .onChange(of: pin[index]) { newValue in
                        print("NewValue: \(newValue)")
                        if newValue.isEmpty {
                            self.code = ""
                        }
                        
                        if self.code.isEmpty {
                            if newValue.count > 1 {
                                pin[index] = String(newValue.prefix(1))
                            }
                            else if newValue.isEmpty {
                                if index > 0 {
                                    focusedField = index - 1
                                }
                            }
                            if newValue.count == 1 {
                                if index < pinLength - 1 {
                                    focusedField = index + 1
                                } else {
                                    focusedField = nil
                                }
                            }
                            
                            print("PIN: \(pin) - newValue: \(newValue)")
                            let pinCode = pin.joined(separator: "")
                            print("Newvalue: \(pinCode)")
                            if pinCode.count == pinLength {
                                focusedField = nil
                                onEnteredCode?(pinCode)
                            } else if pinCode.count == 0 {
                                focusedField = 0
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            focusedField = 0
                        }
                    }
            }
        }
        .padding()
    }
    
    private func updatePin(_ pastedText: String) {
        for i in 0..<pinLength {
            pin[i] = String(pastedText[pastedText.index(pastedText.startIndex, offsetBy: i)])
        }
        focusedField = nil
        onEnteredCode?(pastedText)
    }
}

#Preview {
    PinCodeView()
}

