//
//  ContentView.swift
//  SwiftUIImagePicker
//
//  Created by Simon Ng on 10/6/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var rectDict = [String: [Rect]]()
    @State var rectArray: [Rect] = []
    @State var set: Set<String> = [""]
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var imageName : String = ""
    @State var imageNumber: Int = 0
    
    var body: some View {
        VStack {
            
            Image(uiImage: self.image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                .cornerRadius(15)
                .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
   
                    let pointOfOrigin = (min(value.startLocation.x, value.location.x), min(value.startLocation.y, value.location.y))

                    let width = abs(value.location.x - value.startLocation.x)
                    
                    let height = abs(value.location.y - value.startLocation.y)
                    
                    let rect = Rect(x: pointOfOrigin.0, y: pointOfOrigin.1, width: width, height: height)
                    
                    rectArray.append(rect)
                    
                  //  if set.contains("") {
                  //      rectDict["\($imageName.wrappedValue)"] = rectArray
                  //  }
                  //  else if !set.contains($imageName.wrappedValue) {
                  //      var rectArray2: [Rect] = []
                        
                  //  }
                    
                    
                //    set.insert($imageName.wrappedValue)
                    
                    
                    
                    rectDict["\($imageName.wrappedValue)"] = rectArray
                    
                    var jsonString = """
                    [
                        {
                    """

                    jsonString.append(makeJSON(dict: rectDict, arr:rectArray))
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
            ImagePicker(sourceType: .photoLibrary, rectArray: $rectArray, imageName: $imageName, selectedImage: self.$image)
        }
    }
}

private func makeJSON(dict: Dictionary<String, [Rect]>, arr: Array<Rect>) -> String {
    let size = arr.count
    let last_element = arr[size-1]
    var jsonString = ""
    for (key, rects) in dict {
        jsonString.append("\n        image: \(key),")
        jsonString.append("\n")
        jsonString.append("""
        annotations: [
            {

""")
        
        for rect in rects {
            jsonString.append("                coordinates: { \n")
            jsonString.append("                    x: \((rect.x).truncate(places: 2)), y: \((rect.y).truncate(places: 2)), width: \((rect.width).truncate(places: 2)), height: \((rect.height).truncate(places: 2))\n ")
            jsonString.append("                }\n")
            
            if rect == last_element {
                jsonString.append("             }\n")
            }
            else {
                jsonString.append("             },\n")
            }
        }
    }
    
    return jsonString
}

extension CGFloat {
    func truncate(places : CGFloat)-> CGFloat {
        return CGFloat(floor(pow(10.0, CGFloat(places)) * self)/pow(10.0, CGFloat(places)))
    }
}










//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
 //       ContentView()
  //  }
//}
