//
//  OfficeTableViewCellModel.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 14.07.2022.
//


class OfficeTableViewCellModel {
    let name:           String
    let adress:         String
    let shortAdress:    String
    let status:         String
    let sgraf:          String
    let numbers:        String
    let longtitude:     Double
    let latitude:       Double
    let graf:           [Graf]
    
    init(name: String, adress: String, shortAdress: String, status: String, sgraf: String, numbers: String, longtitude: Double, latitude: Double, graf: [Graf]) {
        self.name           = name
        self.adress         = adress
        self.shortAdress    = shortAdress
        self.status         = status
        self.sgraf          = sgraf
        self.numbers        = numbers
        self.longtitude     = longtitude
        self.latitude       = latitude
        self.graf           = graf
    }
}
