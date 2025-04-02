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
        
        /*ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(spacing: 10) {
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                    HStack {
                        VStack (alignment: .leading) {
                            Image("ic_back_dark", bundle: mainBundle) // Replace with your image name
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 15))
                                .onTapGesture {
                                    print("onNavigateBack")
                                    onNavigateBack()
                                }
                        }
                        .frame(width: 44, height: 32)
                    }
                }
                .frame(width: 393, height: 100)
                .background(.white)
                
                CustomProgressView(steps: [
                    Step(title: "1", state: .active),
                    Step(title: "2", state: .inactive),
                    Step(title: "3", state: .inactive),
                    Step(title: "4", state: .inactive),
                    Step(title: "5", state: .inactive)
                ])
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("title_passport_scanning_passport".localized)
                        .font(.defaultH3.weight(.bold))
                        .foregroundColor(.black)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background {
                            VStack {
                                LoadingDotsView()
                                Spacer()
                            }
                            .padding(.top, 20)
                        }
                }
                .padding(EdgeInsets(top: 20, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    BrandView(isDarked: true)
                    Spacer()
                }
                .frame(height: 128, alignment: .bottom)
            }
            .padding()
            .ignoresSafeArea(.all)
        }.onAppear(perform: {
            onViewAppeared?(self)
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
        }*/
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
