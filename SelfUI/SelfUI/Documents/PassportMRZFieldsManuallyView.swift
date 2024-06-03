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
                    SteppedProgressView(totalSteps: 5, currentStep: 2, progressColor: Color(red: 0, green: 0.64, blue: 0.43), backgroundColor: .gray)
                        .padding(.leading, 30)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("title_enter_mrz_fields".localized)
                        .font(.system(size: 36).weight(.bold))
                        .foregroundColor(.black)
                    ScrollView {
                        VStack (alignment: .leading) {
                            Text("passport_number".localized)
                                .font(.callout)
                                .bold()
                            TextField("Passport number".localized, text: $viewModel.passportNumber)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numbersAndPunctuation)
                        }
                        VStack (alignment: .leading) {
                            Text("date_of_birth".localized)
                                .font(.callout)
                                .bold()
                            TextField("mrz_placeholder".localized, text: $dob)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numbersAndPunctuation)
                                .onSubmit {
                                    // Here you can validate the dateString and convert it to a Date if needed
                                    if let date = parseDate(from: dob) {
                                        print("Date entered: \(date)")
                                    } else {
                                        print("Invalid date format")
                                    }
                                }
                        }
                        
                        VStack (alignment: .leading) {
                            Text("expiry_date".localized)
                                .font(.callout)
                                .bold()
                            TextField("mrz_placeholder".localized, text: $doe)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numbersAndPunctuation)
                                .onSubmit {
                                    // Here you can validate the dateString and convert it to a Date if needed
                                    if let date = parseDate(from: doe) {
                                        print("Date entered: \(date)")
                                    } else {
                                        print("Invalid date format")
                                    }
                                }
                        }
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 12) {
                    ButtonView(title: "Done".localized) {
                        print("Passport number: \(passportNumber) DOB \(dob) DOE \(doe)")
                        onResult?(viewModel.passportNumber, dob, doe)
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
}

#Preview {
    PassportMRZFieldsManuallyView(onNavigateBack: {
        
    })
}
