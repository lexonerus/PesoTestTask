//
//  ThirdViewViewModel.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 14.07.2022.
//

import Foundation

class ThirdViewViewModel {
    
    var phoneNumber = Dynamic("")
    
    func getCurrentLocation() {
        LocationManger.shared.determineMyCurrentLocation()
    }
    
    func getPhoneNumber(inputString: String) {
        self.phoneNumber.value = PhoneNumberExtractor.shared.extractPhoneNumber(inputString: inputString)
    }
    
}
