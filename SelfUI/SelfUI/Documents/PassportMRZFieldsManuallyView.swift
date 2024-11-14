//
//  PassportMRZFieldsManuallyView.swift
//  SelfUI
//
//  Created by Long Pham on 3/6/24.
//

import SwiftUI

class PassportMRZFieldManuallyViewModel: ObservableObject {
    @Published var passportNumber: String = ""
    @Published var dob: String = ""
    @Published var doe: String = ""
    @Published var selectedDate = Date()
    
    @Published var isPassportNumberValid: Bool = true
    @Published var isDobValid: Bool = true
    @Published var isDoeValid: Bool = true
    
}
public struct PassportMRZFieldsManuallyView: View {
    @ObservedObject var viewModel = PassportMRZFieldManuallyViewModel()
    
    public init(documentNumber: String = "", dob: String = "", doe: String = "", onResult: ((_ passportNumber: String, _ dob: String, _ doe: String) -> Void)? = nil, onNavigateBack: @escaping () -> Void) {
        self.onResult = onResult
        self.onNavigateBack = onNavigateBack
        self.viewModel.passportNumber = documentNumber
        if !dob.isEmpty {
            self.viewModel.dob = dob.convertDateString() ?? dob
        }
        
        if !doe.isEmpty {
            self.viewModel.doe = doe.convertDateString() ?? doe
        }
    }
    
    var onResult: ((_ passportNumber: String, _ dob: String, _ doe: String) -> Void)? = nil
    var onNavigateBack: () -> Void
    
    public var body: some View {
        ZStack {
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
                                    print("onNavigationBack")
                                    onNavigateBack()
                                }
                        }
                        .frame(width: 44, height: 32)
                    }
                }
                .frame(width: 393, height: 100)
                .background(.white)
                
                CustomProgressView(steps: [
                    Step(title: "1", state: .done),
                    Step(title: "2", state: .active),
                    Step(title: "3", state: .inactive),
                    Step(title: "4", state: .inactive),
                    Step(title: "5", state: .inactive)
                ])
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("title_enter_mrz_fields".localized)
                        .font(.system(size: 36).weight(.bold))
                        .foregroundColor(.black)
                    ScrollView {
                        VStack (alignment: .leading) {
                            Text("passport_number".localized)
                                .font(.defaultBody)
                                .bold()
                                .foregroundColor(.black)
                            
                            ZStack {
                                HStack(alignment: .center, spacing: 1) {
                                    
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, minHeight: 66, maxHeight: 66, alignment: .leading)
                                .background(Color(red: 0.88, green: 0.88, blue: 0.88))
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(viewModel.isPassportNumberValid ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                                    //
                                    TextField("", text: $viewModel.passportNumber)
                                        .placeholder(when: viewModel.passportNumber.isEmpty) {
                                            Text("Passport number".localized).foregroundColor(.gray)
                                        }
                                        .font(.defaultBody)
                                        .foregroundColor(.black)
                                        .keyboardType(.numbersAndPunctuation)
                                        .onChange(of: viewModel.passportNumber) { newValue in
                                            viewModel.isPassportNumberValid = newValue.count > 0
                                        }
                                        .padding()
                                }
                            }
                            
                            if !viewModel.isPassportNumberValid {
                                Text("This field cannot be empty.")
                                    .foregroundColor(.red)
                            }
                        }
                        VStack (alignment: .leading) {
                            Text("date_of_birth".localized)
                                .font(.defaultBody)
                                .bold()
                                .foregroundColor(.black)
                            HStack(alignment: .center, spacing: 1) {
                                
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, minHeight: 66, maxHeight: 66, alignment: .leading)
                            .background(Color(red: 0.88, green: 0.88, blue: 0.88))
                            .cornerRadius(10)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(viewModel.isDobValid ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                                    
                                    TextField("", text: $viewModel.dob)
                                        .placeholder(when: viewModel.dob.isEmpty) {
                                            Text("mrz_placeholder".localized).foregroundColor(.gray)
                                        }
                                        .font(.defaultBody)
                                        .foregroundColor(.black)
                                        .keyboardType(.numbersAndPunctuation)
                                        .onChange(of: viewModel.dob) { newValue in
                                            viewModel.isDobValid = validateDate(newValue)
                                        }
                                        .padding()
                                }
                            )
                            
                            
                            if !viewModel.isDobValid {
                                Text("Please enter a valid date of birth.")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        
                        VStack (alignment: .leading) {
                            Text("expiry_date".localized)
                                .font(.defaultBody)
                                .bold()
                                .foregroundColor(.black)
                            HStack(alignment: .center, spacing: 1) {
                                
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, minHeight: 66, maxHeight: 66, alignment: .leading)
                            .background(Color(red: 0.88, green: 0.88, blue: 0.88))
                            .cornerRadius(10)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .inset(by: 0.5)
                                        .stroke(viewModel.isDobValid ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                                    
                                    TextField("", text: $viewModel.doe)
                                        .placeholder(when: viewModel.doe.isEmpty) {
                                            Text("mrz_placeholder".localized).foregroundColor(.gray)
                                        }
                                        .font(.defaultBody)
                                        .foregroundColor(.black)
                                        .keyboardType(.numbersAndPunctuation)
                                        .onSubmit {
                                            // Here you can validate the dateString and convert it to a Date if needed
                                            if let date = parseDate(from: viewModel.doe) {
                                                print("Date entered: \(date)")
                                            } else {
                                                print("Invalid date format")
                                            }
                                        }
                                        .onChange(of: viewModel.doe) { newValue in
                                            viewModel.isDoeValid = validateDate(newValue)
                                        }
                                        .padding()
                                }
                            )
                            
                            if !viewModel.isDoeValid {
                                Text("Please enter a valid expiry date.")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Spacer(minLength: 150)
                    } // end of scroll view
                    
                }
                .padding(EdgeInsets(top: 20, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 12) {
                    ButtonView(title: "Done".localized) {
                        let _dob = viewModel.dob.replace("/", with: "")
                        let _doe = viewModel.doe.replace("/", with: "")
                        print("Passport number: \(viewModel.passportNumber) DOB \(_dob) DOE \(_doe)")
                        
                        onResult?(viewModel.passportNumber, _dob, _doe)
                    }
                    
                    ButtonView(title: "Cancel".localized, backgroundColor: .defaultPink) {
                        // TODO: Cancel button
                        onNavigateBack()
                    }
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .padding()
            .ignoresSafeArea(.all)
        }.onTapGesture {
            self.hideKeyboard()
        }
    }
    
    func parseDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.date(from: string)
    }
    
    func validateDate(_ dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: dateString) != nil
    }
}

#Preview {
    PassportMRZFieldsManuallyView(documentNumber: "123456789", dob: "", doe: "241001", onNavigateBack: {
        
    })
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

extension String {
    func convertDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yy/MM/dd"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
