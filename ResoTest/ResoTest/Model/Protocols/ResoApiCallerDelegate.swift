//
//  ResoApiCallerDelegate.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 16.07.2022.
//

import Foundation

protocol ResoApiCallerDelegate: AnyObject {
    func showAlertWithError(error: Error)
}
