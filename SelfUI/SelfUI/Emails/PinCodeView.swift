//
//  PinCodeView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

struct PinCodeView: View {
    @State private var pin: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?
    
    private let pinLength: Int
    private var onEnteredCode: ((_ code: String) -> Void)?
    init(pinLength: Int = 6, onEnteredCode: ((_ code: String) -> Void)? = nil) {
        self.pinLength = pinLength
        self.onEnteredCode = onEnteredCode
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<pinLength, id: \.self) { index in
                TextField("", text: $pin[index])
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.defaultGrayscale)
                    .tag("\(index)")
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.defaultBlue, lineWidth: 1)
                    )
                    .focused($focusedField, equals: index)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { _ in
                        // TODO: Improve paste code here
                        /*if let pastedText = UIPasteboard.general.string, pastedText.count == pinLength {
                            for i in 0..<pinLength {
                                pin[i] = String(pastedText[pastedText.index(pastedText.startIndex, offsetBy: i)])
                            }
                            focusedField = nil
                        }*/
                    }
                    .onChange(of: pin[index]) { newValue in
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
                        
                        print("PIN: \(pin)")
                        let pinCode = pin.joined(separator: "")
                        print("Newvalue: \(pinCode)")
                        if pinCode.count == pinLength {
                            onEnteredCode?(pinCode)
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
}

#Preview {
    PinCodeView()
}

