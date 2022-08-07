//
//  Office.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 14.07.2022.
//

import Foundation

struct Office: Codable {
    let SSHORTNAME:     String?
    let SADDRESS:       String?
    let SSTATUS:        String?
    let SGRAF:          String?
    let SSHORTADDRESS:  String?
    let SPHONE:         String?
    let NLONG:          Double?
    let NLAT:           Double?
    let GRAF:           [Graf]?

}

struct Graf: Codable {
    let SBEGIN:     String?
    let NDAY:       Int?
    let SEND:       String?
}


