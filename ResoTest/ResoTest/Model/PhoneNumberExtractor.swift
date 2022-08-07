//
//  PhoneNumberExtractor.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 15.07.2022.
//

import Foundation

class PhoneNumberExtractor {
    
    static let shared = PhoneNumberExtractor()
    
    func extractPhoneNumber(inputString: String) -> String {
        let numbers = ["0","1","2","3","4","5","6","7","8","9"]
        var data = "8"
        
        for character in inputString {
            if character == ";" {
                break
            } else {
                if numbers.contains(String(character)) {
                    data.append(character)
                }
            }
            
        }
        return data
    }
    
}
