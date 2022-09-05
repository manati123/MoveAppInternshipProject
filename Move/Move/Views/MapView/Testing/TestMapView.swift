//
//  TestMapView.swift
//  Move
//
//  Created by Silviu Preoteasa on 05.09.2022.
//

import SwiftUI
import MapKit

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    static func requestMockData()-> [LandmarkAnnotation]{
        return [
            LandmarkAnnotation(title: "Bengalore",
                               subtitle:"Bengaluru (also called Bangalore) is the capital of India's southern Karnataka state.",
                               coordinate: .init(latitude: 12.9716, longitude: 77.5946)),
            LandmarkAnnotation(title: "Mumbai",
                               subtitle:"Mumbai (formerly called Bombay) is a densely populated city on India’s west coast",
                               coordinate: .init(latitude: 19.0760, longitude: 72.8777))
        ]
    }
}

let clusterID = "clustering"

class TestMapViewCoordinator: NSObject, MKMapViewDelegate {
    static let ReuseID = "clusterAnnotation"
      var mapViewController: TestMapView
        
      init(_ control: TestMapView) {
          self.mapViewController = control
      }
        
      func mapView(_ mapView: MKMapView, viewFor
           annotation: MKAnnotation) -> MKAnnotationView?{
         //Custom View for Annotation
          let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "clusterAnnotation")
          annotationView.canShowCallout = true
          //Your custom image icon
          annotationView.image = UIImage(named: "ClusterDefault")
          annotationView.clusteringIdentifier = clusterID
          let detailsButton = UIButton(type: .detailDisclosure)
          
          annotationView.rightCalloutAccessoryView = detailsButton
          return annotationView
          
       }
}


struct TestMapView: UIViewRepresentable {
    
    let landmarks = LandmarkAnnotation.requestMockData()
    
    func makeCoordinator() -> TestMapViewCoordinator {
        TestMapViewCoordinator(self)
        
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
        
        view.addAnnotations(landmarks)
    }
}
struct TestMapView_Previews: PreviewProvider {
    static var previews: some View {
        TestMapView()
            .ignoresSafeArea()
    }
}
