//
//  Item.swift
//  Introduction to iOS
//
//  Created by Anastasiia ORJI on 9/22/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import Foundation
import MapKit

struct SchoolData {
	var name = ""
	var country = ""
	var lat : CLLocationDegrees = 0
	var lon : CLLocationDegrees = 0
}

class SchoolCollection {
	
	var list = [SchoolData]()
	
	init() {
		
		list.append(SchoolData(name: "WeThinkCode", country: "South Africa", lat: -26.204707, lon: 28.040148))
		list.append(SchoolData(name: "ACADEMY+PLUS", country: "Romania", lat: 46.786002, lon: 23.606803))
		list.append(SchoolData(name: "ACADEMY+MOLDOVA", country: "Moldova", lat: 47.040103, lon: 28.824686))
		list.append(SchoolData(name: "UNIT Factory", country: "Ukraine", lat: 50.469041, lon: 30.462159))
		list.append(SchoolData(name: "The 101", country: "France", lat: 45.739467, lon: 4.817606))
		list.append(SchoolData(name: "19", country: "Belgium", lat: 50.778293, lon: 4.351059))
		list.append(SchoolData(name: "CODAM", country: "The Netherlands", lat: 52.372575, lon: 4.915375))
		list.append(SchoolData(name: "1337", country: "Morocco", lat: 32.882379, lon: -6.897713))
		list.append(SchoolData(name: "21", country: "Russia", lat: 55.797254, lon: 37.579699))
	}
	
}
