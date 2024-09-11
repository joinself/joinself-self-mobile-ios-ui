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
        VStack {
            // stepped progress view
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .done),
                Step(title: "5", state: .active)
            ])
            
            Spacer(minLength: 100)
            VStack(alignment: .leading, spacing: 30) {
                Text("creating_account_title".localized)
                    .font(.defaultBodyLarge)
                    .foregroundColor(.black)
                
                Text("creating_account_description".localized)
                    .font(.defaultBody)
                    .foregroundColor(.black)
                
                Spacer()
                HStack {
                    Spacer()
                    LoadingDotsView()
                    Spacer()
                }
                
                Spacer()
                
                Spacer()
                VStack(spacing: 12) {
                    ButtonView(title: "button_turn_on_notifications".localized) {
                        requestNotificationPermission { isGranted in
                            onNext?()
                        }
                    }
                    
                    BrandView(isDarked: true)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
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
