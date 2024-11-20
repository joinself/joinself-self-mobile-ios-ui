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
    @ObservedObject var cameraManager = CameraManager()
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var currentIndex = 0
    let suggestions = [
        "Scan front of document",
        "Avoid white background",
        "Adjust angle to reduce glare"]
    
    public var onResult: ((MRZInfo?) -> Void)? = nil
    public var onNavigateBack: (() -> Void)? = nil
    public var onSelectNegative: (() -> Void)? = nil
    
    public init(onResult: ((MRZInfo?) -> Void)? = nil) {
        self.onResult = onResult
        cameraManager.onResult = onResult
    }
    
    public var body: some View {
        ZStack {
            // Base view with overlay
            Color.black.ignoresSafeArea()
            CameraPreview(session: cameraManager.session)
                .ignoresSafeArea(.all)
            CardOverlayView(isHighlighted: cameraManager.isValidMRZ)
            
            VStack (spacing: 20) {
                Spacer()
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 363, height: 80)
                    .background(.white)
                    .cornerRadius(8)
                    .overlay {
                        // Heading/H4
                        Text(suggestions[currentIndex])
                            .transition(.opacity)
                            .font(.defaultNormalTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.textPrimary)
                            .frame(width: 340, alignment: .center)
                    }
                
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
    CaptureDocumentView()
}
