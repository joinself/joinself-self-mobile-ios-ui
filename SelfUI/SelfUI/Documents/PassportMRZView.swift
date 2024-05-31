//
//  PassportMRZView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class PassportMRZViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

public struct PassportMRZView: View {
    @ObservedObject var viewModel = PassportMRZViewModel()
    @ObservedObject var cameraManager = CameraManager()
    
    public var onResult: ((String?) -> Void)? = nil
    public init(onResult: ((String?) -> Void)? = nil) {
        self.onResult = onResult
        cameraManager.onResult = onResult
    }
    
    public var body: some View {
        ZStack {
            // Base view with overlay
            Color.black.ignoresSafeArea()
            CameraPreview(session: cameraManager.session)
            .edgesIgnoringSafeArea(.all)
            MRZOverlayView(isHighlighted: !cameraManager.mrzKey.isEmpty)
            
            VStack (spacing: 20) {
                Spacer()
                Text("Having trouble?".localized)
                    .foregroundColor(.white)
                OutlinedButton(title: "Enter data manually".localized, outlineColor: .white, icon: Image("ic_keyboard", bundle: mainBundle))
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 363, height: 80)
                  .background(.white)
                  .cornerRadius(8)
                  .overlay {
                      // Heading/H4
                      Text("Scan photo page")
                        .font(
                          Font.custom("Barlow", size: 25)
                            .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.05, green: 0.11, blue: 0.26))
                        .frame(width: 340, alignment: .center)
                  }
                
                BrandView(isDarked: false)
            }
            .padding()
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    PassportMRZView()
}
