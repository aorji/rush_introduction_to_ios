//
//  FirstViewController.swift
//  Introduction to iOS
//
//  Created by Alina FESYK on 9/22/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

	var chosenSchool = SchoolData()
	
	@IBOutlet weak var navigationBar: UINavigationItem!
	
	@IBAction func segCtrlAction(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }

    @IBOutlet weak var mapView: MKMapView!

    var schoolName = SchoolLocation(title: "UNIT Factory",
                locationName: "Educational institution",
                coordinate: CLLocationCoordinate2D(latitude: 50.469061, longitude: 30.462116))
	
    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenSchool.name.count != 0 {
			schoolName.title = chosenSchool.name
			schoolName.coordinate = CLLocationCoordinate2D(latitude: chosenSchool.lat, longitude: chosenSchool.lon)
        }
		let span = MKCoordinateSpanMake(0.005, 0.005)
		let region = MKCoordinateRegionMake(schoolName.coordinate, span)
		mapView.setRegion(region, animated: true)
		
		let annotation =  MKPointAnnotation()
		annotation.coordinate = schoolName.coordinate
		annotation.title = schoolName.title
		annotation.subtitle = schoolName.locationName
		mapView.addAnnotation(annotation)
		
		navigationBar.title = schoolName.title
		mapView.delegate = self
		mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FirstViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
		guard (annotation.title) != nil else {return nil}
		annotationView.pinTintColor = UIColor.black
		annotationView.canShowCallout = true
		return annotationView
	}
}
