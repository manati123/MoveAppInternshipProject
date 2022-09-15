//
//  MapViewUIKIT.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import SwiftUI
import MapKit


struct ScooterMapView: UIViewRepresentable {
    let viewModel: ScooterMapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        return viewModel.mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {

    }
}
