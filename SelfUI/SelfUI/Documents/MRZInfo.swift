//
//  MRZInfo.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import Foundation
import Vision

public struct MRZInfo {
    let documentNumber: String
    let dateOfBirth: String
    let dateOfExpiry: String
    let checkDigetDocumentNumber: String
}


class OcrUtils {
    
    init() {
    }
    
    private let TAG = String(describing: OcrUtils.self)
    
    private let REGEX_OLD_PASSPORT = "(?<documentNumber>[A-Z0-9<]{9})(?<checkDigitDocumentNumber>[0-9ILDSOG]{1})(?<nationality>[A-Z<]{3})(?<dateOfBirth>[0-9ILDSOG]{6})(?<checkDigitDateOfBirth>[0-9ILDSOG]{1})(?<sex>[FM<]){1}(?<expirationDate>[0-9ILDSOG]{6})(?<checkDigitExpiration>[0-9ILDSOG]{1})"
    private let REGEX_OLD_PASSPORT_CLEAN = "(?<documentNumber>[A-Z0-9<]{9})(?<checkDigitDocumentNumber>[0-9]{1})(?<nationality>[A-Z<]{3})(?<dateOfBirth>[0-9]{6})(?<checkDigitDateOfBirth>[0-9]{1})(?<sex>[FM<]){1}(?<expirationDate>[0-9]{6})(?<checkDigitExpiration>[0-9]{1})"
    private let REGEX_IP_PASSPORT_LINE_1 = "\\bIP[A-Z<]{3}[A-Z0-9<]{9}[0-9]{1}"
    private let REGEX_IP_PASSPORT_LINE_2 = "[0-9]{6}[0-9]{1}[FM<]{1}[0-9]{6}[0-9]{1}[A-Z<]{3}"
    fileprivate static let REGEX_MRZ_TYPE1 = "I[A-Z<]{4}[A-Z0-9]{9}[0-9][A-Z0-9<]{15}[-]*[0-9]{7}[MF<][0-9]{7}[A-Z<]{3}[A-Z0-9<]{11}[0-9][-]*[A-Z<]{30}"
    
    static func parseMRZInfo(mrzString: String) -> MRZInfo? {
        let REGEX_OLD_PASSPORT = "(?<documentNumber>[A-Z0-9<]{9})(?<checkDigitDocumentNumber>[0-9ILDSOG]{1})(?<nationality>[A-Z<]{3})(?<dateOfBirth>[0-9ILDSOG]{6})(?<checkDigitDateOfBirth>[0-9ILDSOG]{1})(?<sex>[FM<]){1}(?<expirationDate>[0-9ILDSOG]{6})(?<checkDigitExpiration>[0-9ILDSOG]{1})"
        let REGEX_OLD_PASSPORT_CLEAN = "(?<documentNumber>[A-Z0-9<]{9})(?<checkDigitDocumentNumber>[0-9]{1})(?<nationality>[A-Z<]{3})(?<dateOfBirth>[0-9]{6})(?<checkDigitDateOfBirth>[0-9]{1})(?<sex>[FM<]){1}(?<expirationDate>[0-9]{6})(?<checkDigitExpiration>[0-9]{1})"
        let REGEX_IP_PASSPORT_LINE_1 = "\\bIP[A-Z<]{3}[A-Z0-9<]{9}[0-9]{1}"
        let REGEX_IP_PASSPORT_LINE_2 = "[0-9]{6}[0-9]{1}[FM<]{1}[0-9]{6}[0-9]{1}[A-Z<]{3}"
        
        let pattern = "^(P|V|D)<([A-Z]{3})([A-Z<]{39})(\\d)(\\n)(\\d{9})(\\d)([A-Z<]{3})(\\d{6})(\\d)(M|F|<)(\\d{6})(\\d)([A-Z0-9<]{14})(\\d)$"
        
        // Create a regular expression object from the pattern
        guard let regex = try? NSRegularExpression(pattern: REGEX_OLD_PASSPORT) else {
            print("Invalid REGEX_OLD_PASSPORT regex")
            return nil
        }
        
        // Check if the MRZ matches the regex pattern
        let range = NSRange(location: 0, length: mrzString.utf16.count)
        let match = regex.firstMatch(in: mrzString, options: [], range: range)
        print("MATCH: \(match)")
        
        let matches = regex.matches(in: mrzString, range: range)
        
        print("MATCHES: \(matches.count) -> numberOfRange: \(matches.first?.numberOfRanges)")
        if let firstMatch = matches.first {
            
            if firstMatch.numberOfRanges >= 9 {
                let rangeOfDocumentNumber = firstMatch.range(at: 1)
                let documentNumber = (mrzString as! NSString).substring(with: rangeOfDocumentNumber)
                
                let rangeOfCheckDigitDocumentNumber = firstMatch.range(at: 2)
                let checkDigitOfDocumentNumber = (mrzString as! NSString).substring(with: rangeOfCheckDigitDocumentNumber)
                
                let rangeOfDOB = firstMatch.range(at: 4)
                let dob = (mrzString as! NSString).substring(with: rangeOfDOB).cleanDate()
                
                let rangeOfEXP = firstMatch.range(at: 7)
                let exp = (mrzString as! NSString).substring(with: rangeOfEXP).cleanDate()
                print("Document Number: \(documentNumber)")
                print("DOB: \(dob)")
                print("EXP: \(exp)")
                
                let mrzInfo = MRZInfo(documentNumber: documentNumber, dateOfBirth: dob, dateOfExpiry: exp, checkDigetDocumentNumber: checkDigitOfDocumentNumber)
                print("MRZInfo: \(mrzInfo)")
                //                cleanDate(matcherLineOldPassportType.group(2)).toInt()
                //                                val dateOfBirthDay = cleanDate(matcherLineOldPassportType.group(4))
                //                                val expirationDate = cleanDate(matcherLineOldPassportType.group(7))
                return mrzInfo
            } else {
                print("First match <-> numberOfRange is not matched.")
                return nil
            }
            /*for index in 0..<firstMatch.numberOfRanges {
             print("Index: \(index)")
             let rg = firstMatch.range(at: index)
             let sub = (mrzString as! NSString).substring(with: rg)
             print("SUB: \(sub)")
             }*/
        } else {
            guard let regexLineIPassportTypeLine1 = try? NSRegularExpression(pattern: REGEX_IP_PASSPORT_LINE_1) else {
                print("Invalid regexLineIPassportTypeLine1 regex")
                return nil
            }
            
            guard let regexLineIPassportTypeLine2 = try? NSRegularExpression(pattern: REGEX_IP_PASSPORT_LINE_2) else {
                print("Invalid regexLineIPassportTypeLine2 regex")
                return nil
            }
            
            let matchesLineIPassportTypeLine1 = regexLineIPassportTypeLine1.matches(in: mrzString, range: range)
            let matchesLineIPassportTypeLine2 = regexLineIPassportTypeLine2.matches(in: mrzString, range: range)
            
            if let firstMatchIPassportLine1 = matchesLineIPassportTypeLine1.first, let firstMatchIPassportLine2 = matchesLineIPassportTypeLine2.first {
                let line1Range = firstMatchIPassportLine1.range(at: 0)
                let line1 = (mrzString as NSString).substring(with: line1Range)
                
                let line2Range = firstMatchIPassportLine2.range(at: 0)
                let line2 = (mrzString as NSString).substring(with: line2Range)
                
                let documentNumber = line1.substring(5, to: 14)
                
                let checkDigitDocumentNumber = line1.substring(14, to: 15).toInt() ?? PassportUtils.calcCheckSum(documentNumber)
                
                let dob = line2.substring(0, to: 6)
                let exp = line2.substring(8, to: 14)
                
                let mrzInfo = MRZInfo(documentNumber: documentNumber, dateOfBirth: dob, dateOfExpiry: exp, checkDigetDocumentNumber: "\(checkDigitDocumentNumber)")
                print("MRZInfo: \(mrzInfo)")
                //                cleanDate(matcherLineOldPassportType.group(2)).toInt()
                //                                val dateOfBirthDay = cleanDate(matcherLineOldPassportType.group(4))
                //                                val expirationDate = cleanDate(matcherLineOldPassportType.group(7))
                return mrzInfo
            }
        }
        
        // Return true if there is a match, false otherwise
        return nil
    }
}


class PassportUtils {
    
    static func getMRZKey(passportNumber: String, dateOfBirth: String, dateOfExpiry: String ) -> String {
        
        // Pad fields if necessary
        let pptNr = pad( passportNumber, fieldLength:9)
        let dob = pad( dateOfBirth, fieldLength:6)
        let exp = pad( dateOfExpiry, fieldLength:6)
        
        // Calculate checksums
        let passportNrChksum = PassportUtils.calcCheckSum(pptNr)
        let dateOfBirthChksum = PassportUtils.calcCheckSum(dob)
        let expiryDateChksum = PassportUtils.calcCheckSum(exp)

        let mrzKey = "\(pptNr)\(passportNrChksum)\(dob)\(dateOfBirthChksum)\(exp)\(expiryDateChksum)"
        
        return mrzKey
    }
    
    static func pad( _ value : String, fieldLength:Int ) -> String {
        // Pad out field lengths with < if they are too short
        let paddedValue = (value + String(repeating: "<", count: fieldLength)).prefix(fieldLength)
        return String(paddedValue)
    }
    
    static func calcCheckSum( _ checkString : String ) -> Int {
        let characterDict  = ["0" : "0", "1" : "1", "2" : "2", "3" : "3", "4" : "4", "5" : "5", "6" : "6", "7" : "7", "8" : "8", "9" : "9", "<" : "0", " " : "0", "A" : "10", "B" : "11", "C" : "12", "D" : "13", "E" : "14", "F" : "15", "G" : "16", "H" : "17", "I" : "18", "J" : "19", "K" : "20", "L" : "21", "M" : "22", "N" : "23", "O" : "24", "P" : "25", "Q" : "26", "R" : "27", "S" : "28","T" : "29", "U" : "30", "V" : "31", "W" : "32", "X" : "33", "Y" : "34", "Z" : "35"]
        
        var sum = 0
        var m = 0
        let multipliers : [Int] = [7, 3, 1]
        for c in checkString {
            guard let lookup = characterDict["\(c)"],
                let number = Int(lookup) else { return 0 }
            let product = number * multipliers[m]
            sum += product
            m = (m+1) % 3
        }
        
        return (sum % 10)
    }
}


extension String {
    func trimmingFillers() -> String {
        return trimmingCharacters(in: CharacterSet(charactersIn: "<"))
    }
}

// MARK: Generic
extension String {
    func replace(_ target: String, with: String) -> String {
        return replacingOccurrences(of: target, with: with, options: .literal, range: nil)
    }
    
    func substring(_ from: Int, to: Int) -> String {
        let fromIndex = index(startIndex, offsetBy: from)
        let toIndex = index(startIndex, offsetBy: to + 1)
        return String(self[fromIndex..<toIndex])
    }
    
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    func cleanDate() -> String {
        var tempDate = self
        tempDate = tempDate.replacingOccurrences(of: "I", with: "1")
        tempDate = tempDate.replacingOccurrences(of: "L", with: "1")
        tempDate = tempDate.replacingOccurrences(of: "D", with: "0")
        tempDate = tempDate.replacingOccurrences(of: "O", with: "0")
        tempDate = tempDate.replacingOccurrences(of: "S", with: "5")
        tempDate = tempDate.replacingOccurrences(of: "S", with: "5")
        tempDate = tempDate.replacingOccurrences(of: "G", with: "6")
        
        return tempDate
    }
    
    func formatFromMRZLine() -> String {
        var result = self.replacingOccurrences(of: " ", with: "")
        result = result.replacingOccurrences(of: "\n", with: "")
        result = result.replacingOccurrences(of: "\t", with: "")
        result = result.replacingOccurrences(of: "\r", with: "")
        result = result.replacingOccurrences(of: "‹", with: "<")
        result = result.replacingOccurrences(of: ".", with: "<")
        result = result.replacingOccurrences(of: "≤", with: "<")
        result = result.replacingOccurrences(of: "'", with: "<")
        result = result.replacingOccurrences(of: "«", with: "<")
        
        return result
    }
}
