//
//  BackupDoneView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackupDoneView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseView {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_backup_done".localized)
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Spacer()
            }
            
            Spacer()
            ButtonView(title: "button_done".localized) {
                onGettingStarted()
            }
        }
    }
}

#Preview {
    BackupDoneView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
