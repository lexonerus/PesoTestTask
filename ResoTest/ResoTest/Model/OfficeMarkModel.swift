//
//  OfficeMark.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 16.07.2022.
//

import MapKit

class OfficeMarkModel: NSObject, MKAnnotation {
    let title:      String?
    let adress:     String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, adress: String?, coordinate: CLLocationCoordinate2D) {
        self.title          = title
        self.adress         = adress
        self.coordinate     = coordinate
    }

}

