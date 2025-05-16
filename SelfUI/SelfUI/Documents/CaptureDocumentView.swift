//
//  CaptureDocumentView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class CaptureDocumentViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

public struct CaptureDocumentView: View {
    @ObservedObject var viewModel = CaptureDocumentViewModel()
    @ObservedObject var cameraManager = CameraManager(cameraPosition: .back, captureMode: .captureFrontPage)
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var currentIndex = 0
    @State private var isScanCardMRZ: Bool = true
    @State private var captureMode: CaptureMode = .detectPassportMRZ
    let suggestions = [
        "Scan front of document",
        "Avoid white background",
        "Adjust angle to reduce glare"]
    
    let backPageSuggestions = [
        "Scan back of document",
        "Avoid white background",
        "Adjust angle to reduce glare"]
    
    public var onResult: ((MRZInfo?) -> Void)? = nil
    public var onCaptureImage: ((UIImage) -> Void)? = nil
    public var onNavigateBack: (() -> Void)? = nil
    public var onSelectNegative: (() -> Void)? = nil
    
    public init(onResult: ((MRZInfo?) -> Void)? = nil, onCaptureImage: ((UIImage) -> Void)? = nil, captureMode: CaptureMode = CaptureMode.detectPassportMRZ) {
        self.onResult = onResult
        self.onCaptureImage = onCaptureImage
        self.captureMode = captureMode
        cameraManager.onResult = onResult
        cameraManager.captureMode = captureMode
    }
    
    public var body: some View {
        ZStack {
            // Base view with overlay
            Color.black.ignoresSafeArea()
            CameraPreview(session: cameraManager.session)
                .onChange(of: cameraManager.isHighlighted) { newValue in
                    if let originalImage = cameraManager.image, let croppedImage = cameraManager.croppedImage , cameraManager.isHighlighted {
                        if cameraManager.captureMode == .detectIDCardMRZ {
                            Utils.vibrate()
                        } else if (cameraManager.captureMode == .captureFrontPage) || cameraManager.captureMode == .captureBackPage {
                            Utils.playCaptureSound()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            onCaptureImage?(croppedImage)
                        })
                    }
                }
                .ignoresSafeArea(.all)
            if cameraManager.captureMode == .detectIDCardMRZ {
                IDMRZCardOverlay(isHighlighted: cameraManager.isHighlighted)
            } else {
                CardOverlayView(isHighlighted: cameraManager.isHighlighted)
            }
                        
            
            VStack (spacing: 20) {
                Spacer()
                
                if cameraManager.isHighlighted{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 363, height: 80)
                        .background(Color.defaultGreen)
                        .cornerRadius(8)
                        .overlay {
                            HStack {
                                Image("ic_checkmark", bundle: mainBundle)
                                Text("Document captured".localized)
                                    .transition(.opacity)
                                    .modifier(Heading4TextStyle())
                            }
                        }
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 363, height: 80)
                        .background(.white)
                        .cornerRadius(8)
                        .overlay {
                            // Heading/H4
                            Text((captureMode == .captureFrontPage) ? suggestions[currentIndex] : backPageSuggestions[currentIndex])
                                .transition(.opacity)
                                .font(.defaultNormalTitle)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.textPrimary)
                                .frame(width: 340, alignment: .center)
                        }
                }
                
                // Testing
                /*if let image = cameraManager.croppedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 150)
                }*/
                
                BrandView(isDarked: true, textColor: .white)
            }
            .padding()
            
            GeometryReader { geometry in
                HStack {
                    ButtonBack(isWhiteBackground: true) {
                        print("back...")
                        presentationMode.wrappedValue.dismiss()
                    }
                }.padding(.leading, Constants.PadLeading)
            }
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            startTimer()
            
            DispatchQueue.global(qos: .background).async {
                self.cameraManager.session.startRunning()
            }
        })
        .onDisappear(perform: {
            print("Camera View disappear.")
            self.cameraManager.session.stopRunning()
        })
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            currentIndex = (currentIndex + 1) % suggestions.count
        }
    }
}

#Preview {
    VStack {
//        CaptureDocumentView(captureMode: .captureCardImage)
        CaptureDocumentView(captureMode: .detectIDCardMRZ)
    }
}
