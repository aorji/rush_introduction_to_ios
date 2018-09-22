//
//  SchoolLocation.swift
//  Introduction to iOS
//
//  Created by Anastasiia ORJI on 9/22/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import Foundation
import MapKit

class SchoolLocation: NSObject, MKAnnotation {
	var title: String?
	var locationName: String
	var coordinate: CLLocationCoordinate2D
	
	init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.locationName = locationName
		self.coordinate = coordinate
		
		super.init()
	}
	
	var subtitle: String? {
		return locationName
	}
}
