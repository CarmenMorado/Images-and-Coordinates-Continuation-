//
//  Model.swift
//  SwiftUIImagePicker2
//
//  Created by Carmen Morado on 11/17/21.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import Foundation
import SwiftUI

struct Model {
    var currentImage: String
   // @State var imageName : String = ""
    private(set) var rectDict = [String: [Rect]]()
    
    init(currentImage: String, imageName: String) {
        self.currentImage = currentImage
      }
    
    mutating func addImage(imageName: String) -> [Rect]{
        if rectDict.keys.contains(imageName) {
            return rectDict[imageName]!
        }
        else {
            rectDict[imageName] = [Rect]()
            return rectDict[imageName]! //[Rect]()
            
        }
    }
    
    mutating func handleGesture(currentImage: String, value: DragGesture.Value) {
        if ((value.location.y >= 0 && value.location.y <= 250) && (value.startLocation.y >= 0 && value.startLocation.y <= 250)) {
        
        let pointOfOrigin = (min(value.startLocation.x, value.location.x), min(value.startLocation.y, value.location.y))

        let width = abs(value.location.x - value.startLocation.x)
        
        let height = abs(value.startLocation.y -  value.location.y)
        
        let rect = Rect(x: pointOfOrigin.0, y: pointOfOrigin.1, width: width, height: height)
        
        var rectArray = [Rect]()
        
        rectArray.append(rect)
        
        if (rectDict["\(currentImage)"]) == nil {
            var rectArray = [Rect]()
            rectArray.append(rect)
            rectDict["\(currentImage)"] = rectArray
        }
        
        else {
            
            rectDict["\(currentImage)"]?.append(contentsOf: rectArray)
        }
        
        }
        
    }
    

    
    func makeJSON(dict: Dictionary<String, [Rect]>, arr: Array<Rect>) -> String {
      
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

        
    }
    
    

 


extension CGFloat {
    func truncate(places : CGFloat)-> CGFloat {
        return CGFloat(floor(pow(10.0, CGFloat(places)) * self)/pow(10.0, CGFloat(places)))
    }
}
