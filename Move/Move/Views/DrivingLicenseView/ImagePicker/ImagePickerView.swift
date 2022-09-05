//
//  ImagePickerView.swift
//  Move
//
//  Created by Silviu Preoteasa on 29.08.2022.
//

import SwiftUI
import UIKit

class ImagePickerViewModel: ObservableObject {
    @Published var image: Image = Image("")
    @Published var isPresented: Bool = false
    @Published var shouldPresentImagePicker = false
    @Published var shouldPresentActionScheet = false
    @Published var shouldPresentCamera = false
}

struct ImagePickerView: View {
    @ObservedObject var viewModel: ImagePickerViewModel
    let onUpload: () -> Void
    var body: some View {
        VStack {
            viewModel.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.8)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 34))
                .shadow(radius: 10)
                .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
                    SUImagePickerView(sourceType: self.viewModel.shouldPresentCamera ? .camera : .photoLibrary, image: self.$viewModel.image, isPresented: self.$viewModel.shouldPresentImagePicker)
                }.actionSheet(isPresented: $viewModel.shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.viewModel.shouldPresentImagePicker = true
                        self.viewModel.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.viewModel.shouldPresentImagePicker = true
                        self.viewModel.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
            Spacer()
            Button("Pick photo") {
                self.viewModel.shouldPresentActionScheet = true
            }.buttonStyle(.filledButton)
                .disabled(false)
                .animation(.default, value: viewModel.image != Image(""))
            Button("Upload selected photo?") {
                self.onUpload()
                
            }.buttonStyle(.filledButton)
                .disabled(viewModel.image != Image("") ? false : true)
                .animation(.default, value: viewModel.image != Image(""))
            
        }
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(viewModel: ImagePickerViewModel(), onUpload: {})
//        Text("F")
    }
}
