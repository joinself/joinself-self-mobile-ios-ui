//
//  SettingsView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var path = [Int]()
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center) {
                Spacer(minLength: 60)
                Text("Licenses")
                    .underline()
                Text("Backup and Restore")
                
                Spacer(minLength: 100)
                Text("Developer options")
                List {
                    Text("Share Logs")
                    Text("Share My QR Image")
                }.listStyle(.plain)
                
                VStack (alignment: .leading) {
                    Text("Environment:")
                        .underline()
                    Text("Version:")
                        .underline()
                }
            }
            .navigationDestination(for: Int.self) { selection in
                
            }
            .listStyle(.plain)
            .navigationTitle("tab_settings".localized)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("ic_back_dark")
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
