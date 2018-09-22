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
                coordinate: CLLocationCoordinate2D(latitude: 50.469713, longitude: 30.462223))
	
    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenSchool.name.count != 0 {
			schoolName.title = chosenSchool.name
			schoolName.coordinate = CLLocationCoordinate2D(latitude: chosenSchool.lat, longitude: chosenSchool.lon)
        }
		let initialLocation = CLLocation(latitude: schoolName.coordinate.latitude, longitude: schoolName.coordinate.longitude)
		navigationBar.title = schoolName.title
		mapView.delegate = self
		mapView.addAnnotation(schoolName)
		centerMapOnLocation(location: initialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension FirstViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SchoolLocation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
