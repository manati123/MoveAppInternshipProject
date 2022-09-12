//
//  MapViewModel.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftUI
import MapKit


extension CLLocationCoordinate2D {
    static func ==(left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> Bool {
        return left.latitude == right.latitude && left.longitude == right.longitude
    }
}

class ScooterMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var locationChanged: Bool = true
    var scooters: [ScooterAnnotation] = [] {
        didSet {
            refreshScooterList()
            
        }
    }
    var onSelectedScooter: (ScooterAnnotation) -> Void = { _ in }
    var onDeselectedScooter: () -> Void = {}
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
        
    }()
    
    func centerOnUser() {
        let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        withAnimation {
            mapView.setRegion(mapRegion, animated: true)
        }
        
    }
    
    func isCenteredOnUser() -> Bool {
        guard let locationManager = locationManager else {
            return false
        }
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            return mapView.centerCoordinate == locationManager.location?.coordinate ?? mapView.region.center
        }
        return false
    }
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location not enabled")
        }
    }
    
    func locationIsDisabled() -> Bool {
        guard let locationManager = locationManager else {
            return false
        }
        if locationManager.authorizationStatus == .denied {
            return true
        }
        return false
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied location")
            mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.770439, longitude: 23.591423), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        case .authorizedAlways, .authorizedWhenInUse:
            print("f")
            mapView.centerCoordinate = locationManager.location!.coordinate
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
        //        checkIfLocationServiceIsEnabled()
        print("Checked")
        //        print("checked")
    }
    
    func refreshScooterList() {
        mapView.removeAnnotations(mapView.annotations)
        if scooters.count != mapView.annotations.count {
            mapView.addAnnotations(scooters)
        }
    }
}

extension ScooterMapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor
                 annotation: MKAnnotation) -> MKAnnotationView?{
        //Custom View for Annotation
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
        
        
        
        if annotation is MKUserLocation {
            let userAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
            userAnnotationView.image = UIImage(named: ImagesEnum.userLocationMapPin.rawValue)
            
            return userAnnotationView
            
        }
        annotationView.clusteringIdentifier = "customView"
        //Your custom image icon
        annotationView.image = UIImage(named: "ClusterDefault")
        if annotation is MKClusterAnnotation {
            //change data about the clusters
            let clusterConvertedAnnotation = annotation as! MKClusterAnnotation
            let numberOfItems = clusterConvertedAnnotation.memberAnnotations.count
            if numberOfItems > 1 {
                let lbl = UILabel()
                annotationView.addSubview(lbl)
                lbl.text = String(numberOfItems)
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.adjustsFontSizeToFitWidth = true;
                NSLayoutConstraint.activate([
                    lbl.widthAnchor.constraint(equalTo: annotationView.widthAnchor, multiplier: 0.5),
                    lbl.heightAnchor.constraint(equalTo: annotationView.heightAnchor),
                    lbl.centerXAnchor.constraint(equalTo: annotationView.centerXAnchor, constant: 2.5),
                    lbl.centerYAnchor.constraint(equalTo: annotationView.centerYAnchor, constant: -3.5)
                ])
                
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        if let scooterAnnotation = view.annotation as? ScooterAnnotation {
            self.onSelectedScooter(scooterAnnotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.onDeselectedScooter()
    }
    
    
}
