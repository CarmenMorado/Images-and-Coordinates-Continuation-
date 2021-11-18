//
//  Model.swift
//  SwiftUIImagePicker2
//
//  Created by Carmen Morado on 11/17/21.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import Foundation
import SwiftUI

class Model {
    var currentImage: String
    private var rectDict = [String: [Rect]]()
    
    init(currentImage: String, imageName: String) {
        self.currentImage = currentImage
      }
    
    func addImage(imageName: String) -> [Rect]{
        if rectDict.keys.contains(imageName) {
            return rectDict[imageName]!
        }
        else {
            rectDict[imageName] = [Rect]()
            return rectDict[imageName]! //[Rect]()
            
        }
    }
    
}
