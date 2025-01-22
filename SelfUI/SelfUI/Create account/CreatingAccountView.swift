//
//  CreatingAccountView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI
import UserNotifications

struct CreatingAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var notificationPermissionGranted = false
    
    var onNext: (() -> ())?
    init(onNext: (() -> Void)? = nil) {
        self.onNext = onNext
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 5){
            ScrollView {
                VStack (spacing: 20) {
                    Text("creating_account_title".localized)
                        .font(.defaultBodyLarge)
                        .foregroundColor(.textPrimary)
                    
                    Text("creating_account_description".localized)
                        .font(.defaultBody)
                        .foregroundColor(.textPrimary)
                    
                    HStack {
                        Spacer()
                        LoadingDotsView()
                        Spacer()
                    }
                }
            }
            ButtonView(title: "button_turn_on_notifications".localized) {
                requestNotificationPermission { isGranted in
                    onNext?()
                }
            }
        }
        
    }
    
    func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                notificationPermissionGranted = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func requestNotificationPermission(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion?(granted)
            }
        }
    }
}

#Preview {
    CreatingAccountView()
}
