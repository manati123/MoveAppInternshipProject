//
//  MapViewUIKIT.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftUI
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
      var mapViewController: MapViewUIKIT
    
        
      init(_ control: MapViewUIKIT) {
          self.mapViewController = control
      }
        
      func mapView(_ mapView: MKMapView, viewFor
           annotation: MKAnnotation) -> MKAnnotationView?{
         //Custom View for Annotation
          let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
          annotationView.canShowCallout = true
          
          
          if annotation is MKUserLocation {
              let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
              mapView.setRegion(mapRegion, animated: true)
              return nil
          }

          annotationView.clusteringIdentifier = "customView"
          let btn = UIButton(type: .detailDisclosure)
          btn.addTarget(self, action: #selector(lalala), for: .touchDown)
          
          annotationView.rightCalloutAccessoryView = btn
//          let bu
          //Your custom image icon
          annotationView.image = UIImage(named: "ClusterDefault")
          
          if annotation is MKClusterAnnotation {
              //change data about the clusters
              let clusterConvertedAnnotation = annotation as! MKClusterAnnotation
              let numberOfItems = clusterConvertedAnnotation.memberAnnotations.count
              if numberOfItems > 1 {
                  let lbl = UILabel(frame: CGRect(x: 6, y: 3, width: 35, height: 15))
                  lbl.text = String(numberOfItems)
                  lbl.translatesAutoresizingMaskIntoConstraints = false
                  
                  annotationView.addSubview(lbl)
              }
              
          }
          
          return annotationView
       }
    
    @objc func lalala() {
        print("Killmeplz")
    }
    
    
    
    
   
}

struct MapViewUIKIT: UIViewRepresentable {
    let landmarks = ScooterAnnotation.requestMockData()
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    /**
     - Description - Replace the body with a make UIView(context:) method that creates and return an empty MKMapView
     */
    func makeUIView(context: Context) -> MKMapView{
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context){
        //If you changing the Map Annotation then you have to remove old Annotations
        //mapView.removeAnnotations(mapView.annotations)
        
        view.delegate = context.coordinator
        view.showsUserLocation = true
//        view.center = view.userLocation.coordinate;
//        view.span.latitudeDelta = 0.2;
//        view.span.longitudeDelta = 0.2;
        
        
        view.addAnnotations(landmarks)
        
    }
}
