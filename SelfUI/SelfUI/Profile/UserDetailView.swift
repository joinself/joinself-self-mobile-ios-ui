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
    @State private var errorDescription: String = ""
    @State private var editFieldState: OutlineTextFieldState = .unspecific
    
    @FocusState private var isFocused: Bool
    @State private var isValidName: Bool = true
    
    let details: String
    let isEditing: Bool
    private var onFinish: (() -> Void)?
    public init(
        isEditing: Bool = false,
        uiImage: Binding<UIImage?> = .constant(nil),
        name: Binding<String> = .constant("Tan Longname"),
        details: String = "Description", onFinish: (() -> Void)? = nil) {
            self._inputImage = uiImage
            self._name = name
            self.details = details
            self.onFinish = onFinish
            self.isEditing = isEditing
            isValidName = name.wrappedValue.count > 0
            
            errorDescription = "enter_name_error".localized
        }
    
    public var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: 138, alignment: .center)
                    .background(.white.opacity(0))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 1)
                            .stroke(Color.defaultGreen, lineWidth: 2)
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
                        if !isEditing {
                            Text(name)
                                .font(
                                    Font.defaultTitle
                                )
                                .minimumScaleFactor(0.6)
                                .lineLimit(2)
                                .foregroundColor(.textPrimary)
    //                            .onTapGesture {
    //                                viewModel.isSheetPresented = true
    //                            }
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
                            
                        } else {
                            Text("message_edit_profile".localized)
                                .font(.navigationTitle)
                                .foregroundStyle(Color.textPrimary)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                    Spacer()
                    if !isEditing {
                        Button {
                            // show editing
                            // showingImagePicker = true
                            onFinish?()
                            
                        } label: {
                            Image("ic_chevron_right", bundle: mainBundle)
                                .padding(.trailing, -8)
                                .frame(width: 24, height: 44)
                                .foregroundColor(.black)
                        }
                    }
                }
                .backgroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .onTapGesture {
                if isEditing {
                    showingImagePicker = true
                }
            }
            
            if isEditing {
                OutlineLabelTextField(label: "message_edit_profile_name".localized, placeHolder: "enter_name_placeholder".localized,
                                      errorDescription: "enter_name_error".localized,
                                      keyboardType: .default,
                                      textInputAutocapitalization: .words,
                                      state: $editFieldState, text: $name, isFocused: _isFocused)
                .onChange(of: name) { newValue in
                    isValidName = newValue.count > 0
                    editFieldState = isValidName ? .valid : .error
                }
            }
        }.onTapGesture {
            if isEditing, isFocused {
                isFocused = false
            }
        }
    }
    
    private func loadImage() {
        print("Image picker is dismissed.")
//        self.onFinish?()
    }
}

#Preview {
    VStack {
        UserDetailView(isEditing: true)
        
        UserDetailView()
        VStack (spacing: 0) {
            NavigationTitleView(title: "Title")
            UserDetailView(name: .constant("Dan Sutherland"))
        }.padding()
        
        BottomSheetView(viewModel: ViewModel())
    }
}

