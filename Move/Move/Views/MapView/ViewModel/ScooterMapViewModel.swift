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
    @Published var firstPopulation = false
    @Published var mockedTripCoordinates = Trip.getMockedTrip()
    var routeOverlay: MKOverlay?
    @Published var mapSnapshot: UIImage = UIImage()
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
    
    
    
    func toggleUserTrackingMode() {
        if mapView.userTrackingMode == .followWithHeading {
            mapView.userTrackingMode = .none
        } else {
            mapView.userTrackingMode = .followWithHeading
        }
    }
    
    func saveMapViewImage() {
        let options = MKMapSnapshotter.Options()
        options.region = self.mapView.region
        options.size = self.mapView.frame.size
        options.scale = UIScreen.main.scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start() {snapshot, error in
            guard snapshot != nil else {
                print(error as Any)
                return
            }
            self.mapSnapshot = snapshot!.image
            self.objectWillChange.send()
        }
        
    }
    
    
    
    
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
    
    func checkMinimumDistanceAndLocationEnabled(selectedScooterLocation: CLLocationCoordinate2D) -> Bool {
        let locationDisabled = self.locationIsDisabled()
        let scooterLocation = CLLocation(latitude: selectedScooterLocation.latitude, longitude: selectedScooterLocation.longitude)
        if !locationDisabled {
            let distanceToScooter = Int(self.locationManager?.location?.distance(from: scooterLocation) ?? 1000)
            if distanceToScooter < 40 {
                return false
            }
            else {
                //                ErrorService().showError(message: "User distance from scooter must be within 40 meters!")
                return true
            }
        } else {
            //            ErrorService().showError(message: "User location is disabled!")
            return true
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
            mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 46.770439, longitude: locationManager.location?.coordinate.longitude ?? 23.591423), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
//            mapView.centerCoordinate = locationManager.location!.coordinate
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func refreshScooterList() {
        
        var scooterAnnotations = [MKAnnotation]()
        
        for scooter in scooters {
            if let scooterAnnotation = scooter as? ScooterAnnotation {
                scooterAnnotations.append(scooterAnnotation)
            }
            
            if let scooterAnnotation = scooter as? MKUserLocation {
                scooterAnnotations.append(scooterAnnotation)
            }
        }
        
        if !firstPopulation {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(scooterAnnotations)
            firstPopulation = true
        }
        
        if scooters.count != scooterAnnotations.count - 1 {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(scooterAnnotations)
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
        
        if let clusterAnnotation = view.annotation as? MKClusterAnnotation {
            var maxBattery = -1
            var maxAnnotation: ScooterAnnotation = ScooterAnnotation(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), scooterData: Scooter())
            for annotation in clusterAnnotation.memberAnnotations {
                if let scooter = annotation as? ScooterAnnotation {
                    if scooter.scooterData.battery! > maxBattery {
                        maxBattery = scooter.scooterData.battery!
                        maxAnnotation = scooter
                    }
                }
            }
            self.onSelectedScooter(maxAnnotation)
        }
        
        if let scooterAnnotation = view.annotation as? ScooterAnnotation {
            print("SELECTED SCOOTER")
            self.onSelectedScooter(scooterAnnotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.onDeselectedScooter()
    }
    
    func drawTrip() {
        if self.mockedTripCoordinates.coordinates.count == 0 {
            print("No coordinates to count")
            return
        }
        
        DispatchQueue.main.async {
            self.routeOverlay = MKPolyline(coordinates: self.mockedTripCoordinates.coordinates, count: self.mockedTripCoordinates.coordinates.count)
            self.mapView.addOverlay(self.routeOverlay!, level: .aboveRoads)
            let customeEdgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 20)
            self.mapView.setVisibleMapRect(self.routeOverlay!.boundingMapRect, edgePadding: customeEdgePadding, animated: false)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.saveSnaphotOfTrip()
//            }
        }
    }
    
    func saveSnaphotOfTrip() {
        let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height

        let region = self.mapView.region

        let mapOptions = MKMapSnapshotter.Options()
            mapOptions.region = region
            mapOptions.size = CGSize(width: screenWidth, height: screenHeight)
            mapOptions.showsBuildings = false

            let snapshotter = MKMapSnapshotter(options: mapOptions)
            snapshotter.start { (snapshotOrNil, errorOrNil) in
            if let error = errorOrNil {
                print(error)
                return
            }
            if let snapshot = snapshotOrNil {
                //set main class snapshot image = snapshot.image
                let sourceImageSize = snapshot.image.size
                let sideLength = min(
                    snapshot.image.size.width,
                    snapshot.image.size.height
                )
                let yOffset = (sourceImageSize.height - sideLength) / 0.4
//                let yOffset = (sourceImageSize.height - sideLength) / 3.0
                let cropRect = CGRect(
                    x: 0,
                    y: yOffset,
                    width: sideLength * 4.1,
                    height: sideLength * 2
                ).integral
                let sourceCGImage = snapshot.image.cgImage!
                let croppedCGImage = sourceCGImage.cropping(to: cropRect)!
                
                self.mapSnapshot = UIImage(cgImage: croppedCGImage, scale: snapshot.image.imageRendererFormat.scale, orientation: snapshot.image.imageOrientation)
            }

            }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKGradientPolylineRenderer(overlay: overlay)
        renderer.setColors([
            UIColor(Color.accentPink)

        ], locations: [])
        renderer.lineCap = .round
        renderer.lineWidth = 3.0
        
        return renderer
    }
    
    
}
