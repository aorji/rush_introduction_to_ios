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
	let locationManager = CLLocationManager()
	var geolocationMode = 0
	var currentCoordinate: CLLocationCoordinate2D?
	
	@IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!
	
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
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
		print("button")
        if geolocationMode == 0 {
            configureLocationServices()
        } else {
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
            geolocationMode = 0
        }
    }
	
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

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
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

extension FirstViewController: CLLocationManagerDelegate{
	
	func configureLocationServices() {
		locationManager.delegate = self
		print("configure location services")
		let status = CLLocationManager.authorizationStatus()
		
		if status == .notDetermined {
			print("status not determined")
			locationManager.requestAlwaysAuthorization()
		} else if status == .authorizedAlways || status == .authorizedWhenInUse {
			print("status allowed")
			beginLocationUpdates(locationManager: locationManager)
		}
	}
	
	func beginLocationUpdates(locationManager: CLLocationManager) {
		print("begin location updates")
		geolocationMode = 1
		mapView.showsUserLocation = true
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()
	}
	
	func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
		let zoomRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
		mapView.setRegion(zoomRegion, animated: true)
	}
	
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location manager (updated location)")
        guard let latestLocation = locations.first else { return }
        zoomToLatestLocation(with: latestLocation.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
}
