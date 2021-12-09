//
//  ContentView.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var imageName : String = ""
    @State var gesturesDict = [String: [Rect2]]()
    @State var currentImage = ""
    @ObservedObject var viewModel: ViewModel

    
    var body: some View {
        
        VStack {
            
            if $imageName.wrappedValue != "" {
            ZStack {
               
                    
                    Image(uiImage: self.image)
                        .resizable()
                    //width: UIScreen.main.bounds.width - 40,
                        .frame(height: 250)
                        .cornerRadius(15)
                        .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
                            if ((value.location.y >= 0 && value.location.y <= 250) && (value.startLocation.y >= 0 && value.startLocation.y <= 250)) {
                                let rect2 = Rect2(X: value.location.x, Y: value.location.y, startX: value.startLocation.x, startY: value.startLocation.y)
                                var gestures = [Rect2]()
                                gestures.append(rect2)
                                if (gesturesDict["\($imageName.wrappedValue)"]) == nil {
                                    var gestures = [Rect2]()
                                    gestures.append(rect2)
                                    gesturesDict["\($imageName.wrappedValue)"] = gestures
                                }
                        
                                else {
                                    gesturesDict["\($imageName.wrappedValue)"]?.append(contentsOf: gestures)
                                }
                        
                            }

                    
                            viewModel.handleGesture(currentImage: $imageName.wrappedValue, value: value)
                        }))
            
                        //.edgesIgnoringSafeArea(.all)
                //}
                
                if gesturesDict["\($imageName.wrappedValue)"] != nil {
                    
                    ForEach(gesturesDict["\($imageName.wrappedValue)"]!,  id: \.self) { gesture in
                        Path { path in
                            path.move(to: CGPoint(x: gesture.X, y: gesture.startY + 185))
                            path.addLine(to: CGPoint(x: gesture.startX, y: gesture.startY + 185))
                            path.addLine(to: CGPoint(x: gesture.startX, y: gesture.Y + 185))
                            path.addLine(to: CGPoint(x: gesture.X, y: gesture.Y + 185))
                            path.addLine(to: CGPoint(x: gesture.X, y: gesture.startY + 185))
                            path.closeSubpath()
                        }
                        .stroke(lineWidth: 3)
                        .fill(Color.purple)
                    }
                }
                
            }
            
            Button(action: {
                var jsonString = """
                [
                    {
                """

                jsonString.append(viewModel.makeJSON(dict: viewModel.rectDict, arr: viewModel.rectDict[$imageName.wrappedValue]!))
                jsonString.append("""
                        ]
                    }
                ]
                """)
               print(jsonString)
                
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                    in: .userDomainMask).first {
                    let pathWithFilename = documentDirectory.appendingPathComponent("Essaie.json")
                    do {
                        try jsonString.write(to: pathWithFilename,
                                             atomically: true,
                                             encoding: .utf8)
                    } catch {
                        // Handle error
                    }
                }
            }) {
                //HStack {
                //   Image(systemName: "photo")
                //        .font(.system(size: 20))
                        
                    Text("Generate JSON")
                        .font(.headline)
               // }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
     
                
            }}
            Spacer()
                .frame(height:10)
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
