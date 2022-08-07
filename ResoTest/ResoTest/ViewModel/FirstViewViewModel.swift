//
//  TableViewViewModel.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 14.07.2022.
//

import Foundation

class FirstViewViewModel {

    var buttonText = Dynamic("")
    
    func updateButtonText() {
        self.buttonText.value = "Получить список    офисов"
    }
        
}
