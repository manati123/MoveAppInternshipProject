////
////  UnlockCoordinatorView.swift
////  Move
////
////  Created by Preoteasa Ioan-Silviu on 20.09.2022.
////
//
//import SwiftUI
//
//enum UnlockCoordinatorEnum: String {
//    case success = "Success"
//    case number = "Number"
//    case NFC = "NFC"
//    case QR = "QR"
//}
//
//struct UnlockCoordinatorView: View {
//    @State var unlockState: UnlockCoordinatorEnum? = .number
//    @State var selectedScooter: Scooter = .init()
//    let goBackToMap:() -> Void
//    var body: some View {
//        NavigationView {
//            ZStack {
//                NavigationLink(destination: UnlockSuccessfull(goToStartRide: {goBackToMap()})
//                    .navigationBarHidden(true)
//                    .ignoresSafeArea()
//                    .transition(.slide.animation(.default)),
//                               tag: .success,
//                               selection: $unlockState
//                ){
//                    EmptyView()
//                }.transition(.slide.animation(.default))
//
//                NavigationLink(destination: ScooterSerialNumberView(onGoBack: {goBackToMap()}, onGoToLoad: {self.unlockState = .success})
//                    .navigationBarHidden(true)
//                    .ignoresSafeArea()
//                    .transition(.slide.animation(.default)),
//                               tag: .success,
//                               selection: $unlockState
//                ){
//                    EmptyView()
//                }.transition(.slide.animation(.default))
//            }
//        }
//    }
//}
//
//struct UnlockCoordinatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnlockCoordinatorView(goBackToMap: {})
//    }
//}
