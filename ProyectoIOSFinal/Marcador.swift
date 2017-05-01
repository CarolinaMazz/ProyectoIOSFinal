//
//  Marcador.swift
//  ProyectoIOSFinal
//
//  Created by Carolina Mazzaglia on 30/04/17.
//  Copyright © 2017 Carolina Mazzaglia. All rights reserved.
//

import UIKit
import MapKit

class Marcador: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(title:String, coordinate:CLLocationCoordinate2D, subtitle:String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
        
        super.init()
    }

}
