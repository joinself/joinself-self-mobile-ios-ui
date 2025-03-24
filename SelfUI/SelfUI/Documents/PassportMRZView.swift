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
    
    public var onResult: ((MRZInfo?) -> Void)? = nil
    public var onNavigateBack: (() -> Void)? = nil
    public var onSelectNegative: (() -> Void)? = nil
    
    @Environment(\.presentationMode) private var presentationMode
    private var onEnterDataManually: (() -> Void)?
    
    public init(onEnterDataManually: (() -> Void)? = nil, onBack: (() -> Void)? = nil, onResult: ((MRZInfo?) -> Void)? = nil) {
        self.onResult = onResult
        self.onEnterDataManually = onEnterDataManually
        self.onNavigateBack = onBack
        cameraManager.onResult = onResult
    }
    
    public var body: some View {
        BaseView(enableBackNavigation: true, backgroundColor: .black, brandTextColor: .white, content: {
            ZStack {
                CameraPreview(session: cameraManager.session)
                .edgesIgnoringSafeArea(.all)
                MRZOverlayView(isHighlighted: cameraManager.isHighlighted)
                
                VStack (spacing: 20) {
                    HStack {
                        NavBackButton(isWhiteBackground: true) {
                            onNavigateBack?()
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                        Spacer()
                    }
                    .padding(.top, 64)
                    .padding(.leading, 24)
                    Spacer()
                    Text("Having trouble?".localized)
                        .modifier(Body1TextStyle(color: .white))
                    OutlinedButton(title: "Enter data manually".localized, outlineColor: .white, icon: Image("ic_keyboard", bundle: mainBundle)) {
                        onEnterDataManually?()
                    }.padding()
                    
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 363, height: 80)
                      .background(.white)
                      .cornerRadius(8)
                      .overlay {
                          Text("Scan photo page")
                              .modifier(Heading4TextStyle())
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.05, green: 0.11, blue: 0.26))
                            .frame(width: 340, alignment: .center)
                      }
                }
                .ignoresSafeArea()
            }
        })
        .ignoresSafeArea()
        .onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
                self.cameraManager.session.startRunning()
            }
        })
        .onDisappear(perform: {
            print("Camera View disappear.")
            self.cameraManager.session.stopRunning()
        })
    }
}

#Preview {
    PassportMRZView()
}
