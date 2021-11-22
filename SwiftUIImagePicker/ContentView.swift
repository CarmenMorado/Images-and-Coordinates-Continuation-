//
//  ContentView.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
   // @State var rectArray: [Rect] = []
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var imageName : String = ""
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            
            Image(uiImage: self.image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                .cornerRadius(15)
                .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
                    
                    viewModel.handleGesture(currentImage: $imageName.wrappedValue, value: value)
                }))
            
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                        
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, imageName: $imageName, selectedImage: self.$image)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    let viewModel = ViewModel()
//    static var previews: some View {
//        ContentView(viewModel: viewModel)
//   }
//}
