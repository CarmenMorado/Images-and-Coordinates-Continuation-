//
//  ViewModel.swift
//  SwiftUIImagePicker2
//
//  Created by Carmen Morado on 11/19/21.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject  {
    
    @Published private var model = Model(currentImage: "", imageName: "")
    
 //   var rectDict: [String: [Rect]] {
 //       return model.rectDict
//    }
    
//    var rectArray: [Rect] {
//        get { return model.rectArray}
        //set { model.rectArray = newValue}
//    }
    
    func addImage(imageName: String) {
        model.addImage(imageName: imageName)
    }
    
    func handleGesture(currentImage: String, value: DragGesture.Value) {
        model.handleGesture(currentImage: currentImage, value: value)
    }
}
