//
//  BackupInfoView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackupInfoView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_backup".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_backup".localized)
                    .font(Font.defaultBody)
                  .lineSpacing(1.14)
                  .foregroundColor(.black)
                Spacer()
            }
            .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_backup_now".localized) {
                    onGettingStarted()
                }
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavBackButton(isWhiteBackground: false) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    BackupInfoView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
