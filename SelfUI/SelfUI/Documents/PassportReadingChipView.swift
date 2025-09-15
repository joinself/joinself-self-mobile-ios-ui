//
//  PassportReadingChipView.swift
//  SelfUI
//
//  Created by Long Pham on 31/5/24.
//

import SwiftUI

class PassportReadingChipViewModel: ObservableObject {
    @Published var showingAlert = false
}

public struct PassportReadingChipView: View {
    
    @ObservedObject var viewModel = PassportReadingChipViewModel()
    
    public init(onViewAppeared: ((PassportReadingChipView) -> Void)? = nil, onNavigateBack: @escaping () -> Void) {
        self.onViewAppeared = onViewAppeared
        self.onNavigateBack = onNavigateBack
        Utils.instance.applyDefaultFonts()
    }
    
    var onNavigateBack: () -> Void
    var onViewAppeared: ((PassportReadingChipView) -> Void)? = nil
    public var onCancel: (() -> Void)? = nil
    public var onRetry: (() -> Void)? = nil
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 4, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_passport_scanning_passport".localized)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                
                HStack {
                    Spacer()
                    LoadingDotsView()
                    Spacer()
                }
                Spacer()
            }
        })
        .alert("Verification Error", isPresented: $viewModel.showingAlert) {
            Button {
                onRetry?()
            } label: {
                Text("Scan Passport Again")
                    .font(
                        Font.custom("SF Pro", size: 15)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.17, green: 0.49, blue: 0.96))
                    .frame(width: 191, height: 20, alignment: .center)
            }
            
            Button("Cancel") {
                // Handle second option action
                onCancel?()
            }
        }
    }
    
    public func displayAlert(showingAlert: Bool) {
        viewModel.showingAlert = showingAlert
    }
}

#Preview {
    PassportReadingChipView(onViewAppeared: { view in
        
    }, onNavigateBack: {
        
    })
}
