//
//  OnboardingSafetyView.swift
//  Move
//
//  Created by Silviu Preoteasa on 08.08.2022.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
    var body: some View {
        withAnimation {
            self.getView()
        }
        
    }
    
    @ViewBuilder
    func getView() -> some View {
        AnyView(
            VStack(alignment: .leading) {
                Image(viewModel.onboardingModel.image)
                    .resizable()
                    .scaledToFit()
                HStack {
                    Text(viewModel.onboardingModel.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Button("Skip") { }
                    
                }.padding()
                Text(viewModel.onboardingModel.text)
                    .padding()
                Spacer()
                HStack {
                    ForEach(0..<5) {
                        if $0 == self.viewModel.slideCounter {
                            Text("_")
                        }
                        else {
                            Text(".")
                        }
                    }
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1)){
                            self.viewModel.checkIfOnboardingIsFinal()
                        }
                    }
                label: {
                    Text("Next \(Image(systemName: "arrow.right"))")
                        .opacity(viewModel.shouldHide ? 0 : 1)
                        .frame(minWidth: 0)
                        .padding()
                        .foregroundColor(.white)
                    
                }
                .background(Color("NextButtonColor"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .opacity(viewModel.shouldHide ? 0 : 1)
                    
                    
                }.padding()
                
                Spacer()
            }.ignoresSafeArea()
            
            
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OnboardingViewModel())
    }
}
