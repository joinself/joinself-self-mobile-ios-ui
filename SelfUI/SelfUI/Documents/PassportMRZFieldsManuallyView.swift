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
    
}
public struct PassportMRZFieldsManuallyView: View {
    @ObservedObject var viewModel = PassportMRZFieldManuallyViewModel()
    @State private var dob: String = ""
    @State private var doe: String = ""
    @State private var passportNumber: String = ""
    @State private var selectedDate = Date()
    
    @State private var isPassportNumberValid: Bool = true
    @State private var isDobValid: Bool = true
    @State private var isDoeValid: Bool = true
    
    
    public init(onResult: ((_ passportNumber: String, _ dob: String, _ doe: String) -> Void)? = nil, onNavigateBack: @escaping () -> Void) {
        self.onResult = onResult
        self.onNavigateBack = onNavigateBack
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
                
                
                // stepped progress view
                ZStack(alignment: .center) {
                    SteppedProgressView(totalSteps: 5, currentStep: 2, progressColor: .defaultGreen, backgroundColor: .defaultGray)
                    //                        .padding(.leading, 30)
                }
                
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
                                        .stroke(isPassportNumberValid ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                                    //
                                    TextField("", text: $passportNumber)
                                        .placeholder(when: passportNumber.isEmpty) {
                                            Text("Passport number".localized).foregroundColor(.gray)
                                        }
                                        .font(.defaultBody)
                                        .foregroundColor(.black)
                                        .keyboardType(.numbersAndPunctuation)
                                        .onChange(of: passportNumber) { newValue in
                                            isPassportNumberValid = newValue.count > 0
                                        }
                                        .padding()
                                }
                            }
                            
                            if !isPassportNumberValid {
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
                                        .stroke(isDobValid ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                                    
                                    TextField("", text: $dob)
                                        .placeholder(when: dob.isEmpty) {
                                            Text("mrz_placeholder".localized).foregroundColor(.gray)
                                        }
                                        .font(.defaultBody)
                                        .foregroundColor(.black)
                                        .keyboardType(.numbersAndPunctuation)
                                        .onChange(of: dob) { newValue in
                                            isDobValid = validateDate(newValue)
                                        }
                                        .padding()
                                }
                            )
                            
                            
                            if !isDobValid {
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
                                        .stroke(isDobValid ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                                    
                                    TextField("", text: $doe)
                                        .placeholder(when: doe.isEmpty) {
                                            Text("mrz_placeholder".localized).foregroundColor(.gray)
                                        }
                                        .font(.defaultBody)
                                        .foregroundColor(.black)
                                        .keyboardType(.numbersAndPunctuation)
                                        .onSubmit {
                                            // Here you can validate the dateString and convert it to a Date if needed
                                            if let date = parseDate(from: doe) {
                                                print("Date entered: \(date)")
                                            } else {
                                                print("Invalid date format")
                                            }
                                        }
                                        .onChange(of: doe) { newValue in
                                            isDoeValid = validateDate(newValue)
                                        }
                                        .padding()
                                }
                            )
                            
                            if !isDoeValid {
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
                        let _dob = dob.replace("/", with: "")
                        let _doe = doe.replace("/", with: "")
                        print("Passport number: \(passportNumber) DOB \(dob) DOE \(doe)")
                        
                        onResult?(passportNumber, _dob, _doe)
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
    PassportMRZFieldsManuallyView(onNavigateBack: {
        
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
