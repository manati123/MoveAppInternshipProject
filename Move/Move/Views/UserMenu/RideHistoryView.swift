//
//  RideListView.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 22.09.2022.
//

import SwiftUI
import CoreLocation

struct RideHistoryView: View {
    @State var rides: [RideInformation] = .init()
    @State var serverRides: [ServerRide] = []
    @ObservedObject var userViewModel: UserViewModel
    let onGoBack:() -> Void
    @State var numberOfRides = 3
    @State var dragged = false
    var body: some View {
        VStack {
            TopBarWithBackAndIcon(text: "History", onGoBack: onGoBack, icon: "")
                .padding(.bottom, 44)
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    print("haha")
                    if !dragged {
                        self.numberOfRides = 10
                    } else {
                        self.numberOfRides = 3
                    }
                    dragged.toggle()
                    }
                LazyVStack(spacing: 12) {
                    ForEach(0..<self.numberOfRides, id: \.self) { _ in
                        RideInformationCard(ride: RideInformation(initialAddress: "Caminul 16 Hasdeu", finishAddress: "Str. Lunii 2A", distance: 4.2, time: "00:15 min"))
                    }
                }
                .padding(.top, 10)
            }.coordinateSpace(name: "pullToRefresh")
        }.onAppear {
//            self.loadServerRides()
        }
    }
    
    func convertLocation(giveNameHandler:@escaping (String) -> Void, coordinates: [Double]) {
        let location = CLLocation(latitude: 23.1, longitude: coordinates[0])
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if error == nil {
                giveNameHandler(placemarks?.first?.name ?? "Address Unavailable")
            }
            else {
                print(error as Any)
            }
        }
    }
    
    func loadServerRides() {
        RideAPI().getUserRides(pageSize: 0, pageNumber: 0, token: UserDefaultsService().loadTokenFromDefaults()) { result in
            switch result {
            case .success(let data):
                self.serverRides = data
                for ride in self.serverRides {
                    var initialAddress = ""
                    var finalAddress = ""
                    
                    convertLocation(giveNameHandler: { address in
                        initialAddress = address
                    }, coordinates: ride.startLocation.coordinates)
                    
                    convertLocation(giveNameHandler: { address in
                        finalAddress = address
                    }, coordinates: ride.endLLocation.coordinates)
                    
                    var timeInSeconds = (((ride.duration % 86400000) % 3600000) / 1000)
                    var minutes = timeInSeconds % 60
                    var hours = minutes % 60
                    let time = "\(hours) : \(minutes) min"
                    let card = RideInformation(initialAddress: initialAddress, finishAddress: finalAddress, distance: Double(((ride.distance / 1000) * 10 ) / 10), time: time)
                    self.rides.append(card)
                    
//                    convertLocation(giveNameHandler: { address in
//                        self.rides.append(RideInformation(initialAddress: <#T##String#>, finishAddress: <#T##String#>, distance: <#T##Double#>, time: <#T##String#>))
//                    }, coordinates: ride.endLocation.coordinates)
                }
            case .failure(let error):
                ErrorService().showError(message: ErrorService().getServerErrorMessage(error))
            }
            
        }
    }
}

struct RideHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        RideHistoryView(userViewModel: .init(userDefaultsService: .init()), onGoBack: {})
    }
}
