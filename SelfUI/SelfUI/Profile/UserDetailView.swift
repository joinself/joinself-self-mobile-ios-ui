//
//  UserDetailView.swift
//  SelfUI
//
//  Created by Long Pham on 4/10/24.
//

import SwiftUI
class ViewModel: ObservableObject {
    @Published var isSheetPresented: Bool = false
    @Published var name: String = ""
}

struct BottomSheetView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $viewModel.name)
                .foregroundStyle(Color.white)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.defaultGray)
                .padding()
            
            Button(action: {
                viewModel.isSheetPresented = false
            }) {
                Text("Done")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .ignoresSafeArea()
        .background(Color.white)
    }
}


public struct UserDetailView: View {
    @State private var showingImagePicker = false
    @Binding private var inputImage: UIImage?
    @StateObject private var viewModel = ViewModel()
    
    @Binding private var name: String
    let details: String
    private var onFinish: (() -> Void)?
    public init(uiImage: Binding<UIImage?> = .constant(nil), name: Binding<String> = .constant("Tan Longname"), details: String = "Description", onFinish: (() -> Void)? = nil) {
        self._inputImage = uiImage
        self._name = name
        self.details = details
        self.onFinish = onFinish
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, maxHeight: 138, alignment: .center)
              .background(.white.opacity(0))
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .inset(by: 1)
                  .stroke(Color(red: 0, green: 0.78, blue: 0.53), lineWidth: 2)
              )
            
            
            HStack(alignment: .center, spacing: 11) {
                if inputImage != nil {
                    Image(uiImage: inputImage!)
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .foregroundColor(.defaultBlue)
                      .clipShape(Circle())
                      .frame(width: Constants.AvatarWidth, height: Constants.AvatarWidth)
                } else {
                    Image(systemName: "person.crop.rectangle.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .foregroundColor(.defaultBlue)
                      .clipShape(Circle())
                      .frame(width: Constants.AvatarWidth, height: Constants.AvatarWidth)
                }
                VStack (alignment: .leading) {
                    // Heading/H3
                    Text(name)
                      .font(
                        Font.defaultTitle
                      )
                      .minimumScaleFactor(0.6)
                      .lineLimit(2)
                      .foregroundColor(.textPrimary)
                      .onTapGesture {
                          viewModel.isSheetPresented = true
                      }
                      .padding(0)
                      .multilineTextAlignment(.leading)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .sheet(isPresented: $viewModel.isSheetPresented, onDismiss: {
                          print("Edit name dismissed.")
                          name = viewModel.name
                      }, content: {
                          BottomSheetView(viewModel: viewModel)
                      })
                    
                    if !details.isEmpty {
                        Text(details)
                            .foregroundStyle(Color.defaultGreen)
                    }
                    
                }
                Spacer()
                Button {
                    // show editing
                    showingImagePicker = true
                    
                } label: {
                    Image("ic_chevron_right", bundle: mainBundle)
                        .padding(.trailing, -8)
                        .frame(width: 24, height: 44)
                        .foregroundColor(.black)
                }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }

                
            }
            .backgroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
    
    private func loadImage() {
        print("Image picker is dismissed.")
        self.onFinish?()
    }
}

#Preview {
    VStack {
        UserDetailView()
        UserDetailView(name: .constant("Dan Sutherland"))
        BottomSheetView(viewModel: ViewModel())
    }
}

