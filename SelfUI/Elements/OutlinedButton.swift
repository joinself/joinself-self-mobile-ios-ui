//
//  OutlinedButton.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

class OutlinedButtonViewModel: ObservableObject {
    @Published var title: String = ""
}

struct OutlinedButton: View {
    @ObservedObject var viewModel = OutlinedButtonViewModel()
    
    var onClicked: (() -> Void)? = nil
    
    
    init(title: String, onClicked: (() -> Void)? = nil) {
        self.onClicked = onClicked
        self.viewModel.title = title
        
        self.applyDefaultFonts()
    }
    
    private func applyDefaultFonts() {
        UIFont.jbs_registerFont(
            withFilenameString: "Barlow-Bold.ttf",
            bundle: Bundle(identifier: mainBundleId)!
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Barlow-Regular.ttf",
            bundle: Bundle(identifier: mainBundleId)!
        )
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Text(viewModel.title)
            .font(Font.custom("Barlow", size: 17).weight(.bold))
            .tracking(0.85)
            .textCase(.uppercase)
            .foregroundColor(Color(red: 0, green: 0.64, blue: 0.43))
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .frame(width: 363, height: 44)
        .cornerRadius(40)
        .overlay(
          RoundedRectangle(cornerRadius: 40)
            .inset(by: 1)
            .stroke(Color(red: 0, green: 0.64, blue: 0.43), lineWidth: 1)
        )
        .onTapGesture {
            onClicked?()
        }
    }
}

#Preview {
    OutlinedButton(title: "i don’t have a passportt", onClicked: {
        
    })
}
