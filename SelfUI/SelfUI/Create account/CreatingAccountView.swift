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
            VStack (spacing: 30) {
                Text("creating_account_title".localized)
                    .modifier(Heading2TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                
                Text("creating_account_description".localized)
                    .modifier(Body1TextStyle())
                
                Spacer()
                LoadingDotsView()
                Spacer()
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
