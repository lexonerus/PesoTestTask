//
//  SecondViewViewModel.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 14.07.2022.
//

import Foundation

class SecondViewViewModel {

    var cellModels = Dynamic([OfficeTableViewCellModel]())
    
    func updateCells(models: [Office]) {
        self.cellModels.value = models.compactMap({
            OfficeTableViewCellModel(
                name:           ($0.SSHORTNAME ?? "n/a"),
                adress:         ($0.SADDRESS ?? "n/a"),
                shortAdress:    ($0.SSHORTADDRESS ?? "n/a"),
                status:         ($0.SSTATUS ?? "n/a"),
                sgraf:          ($0.SGRAF ?? "n/a"),
                numbers:        ($0.SPHONE ?? "n/a"),
                longtitude:     ($0.NLONG ?? 0.0),
                latitude:       ($0.NLAT ?? 0.0),
                graf:           ($0.GRAF ?? [Graf]())
                
            )
        })
    }
    
    func getCurrentLocation() {
        LocationManger.shared.determineMyCurrentLocation()
    }
    
}
