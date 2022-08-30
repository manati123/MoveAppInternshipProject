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
}

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: Image
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }
    
}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: Image
    @Binding var isPresented: Bool
    
    init(image: Binding<Image>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = Image(uiImage: image)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}

struct ImagePickerView: View {
    
    @StateObject var viewModel: ImagePickerViewModel
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    var body: some View {
        VStack {
            viewModel.image
                .resizable()
                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.8)
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 34))
                .overlay(RoundedRectangle(cornerRadius: 34).stroke(Color.neutralGray, lineWidth: 4))
//                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .onTapGesture { self.shouldPresentActionScheet = true }
                .sheet(isPresented: $shouldPresentImagePicker) {
                    SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$viewModel.image, isPresented: self.$shouldPresentImagePicker)
                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = true
                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        self.shouldPresentImagePicker = true
                        self.shouldPresentCamera = false
                    }), ActionSheet.Button.cancel()])
                }
            Spacer()
            Button("Upload selected photo?") {
                
            }.buttonStyle(.filledButton)
                .disabled(viewModel.image != Image("") ? false : true)
                .animation(.default, value: viewModel.image != Image(""))
            
        }
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(viewModel: ImagePickerViewModel())
//        Text("F")
    }
}
