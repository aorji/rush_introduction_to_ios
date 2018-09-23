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

extension FirstViewController: CLLocationManagerDelegate{
	
	func configureLocationServices() {
		locationManager.delegate = self
		let status = CLLocationManager.authorizationStatus()
		
		if status == .notDetermined {
			locationManager.requestAlwaysAuthorization()
		} else if status == .authorizedAlways || status == .authorizedWhenInUse {
			beginLocationUpdates(locationManager: locationManager)
		}
	}
	
	func beginLocationUpdates(locationManager: CLLocationManager) {
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
		guard let latestLocation = locations.first else { return }
		locationManager.stopUpdatingLocation()
        zoomToLatestLocation(with: latestLocation.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
}
