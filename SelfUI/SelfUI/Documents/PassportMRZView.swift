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
    public var onNavigateBack: (() -> Void)? = nil
    public var onSelectNegative: (() -> Void)? = nil
    
    public init(onResult: ((String?) -> Void)? = nil) {
        self.onResult = onResult
        cameraManager.onResult = onResult
    }
    
    public var body: some View {
        VStack {
            ZStack {
                // Base view with overlay
                Color.black.ignoresSafeArea()
                CameraPreview(session: cameraManager.session)
                .edgesIgnoringSafeArea(.all)
                MRZOverlayView(isHighlighted: !cameraManager.mrzKey.isEmpty)
                
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(spacing: 10) {
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        HStack {
                            VStack (alignment: .leading) {
                                Image("ic_back", bundle: mainBundle)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 15))
                                    .onTapGesture {
                                        print("onNavigationBack")
                                        onNavigateBack?()
                                    }
                            }
                            .frame(width: 44, height: 32)
                        }
                    }
                    .frame(width: geometry.size.width, height: 100)
                    .background(.clear)
                }
                
                VStack (spacing: 20) {
                    Spacer()
                    Text("Having trouble?".localized)
                        .foregroundColor(.white)
                    OutlinedButton(title: "Enter data manually".localized, outlineColor: .white, icon: Image("ic_keyboard", bundle: mainBundle)) {
                        onSelectNegative?()
                    }
                    
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
