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
    
    var rectDict: [String: [Rect]] {
        return model.rectDict
    }
    
    var currentImage: String {
        return model.currentImage
    }
    
    func handleGesture(currentImage: String, value: DragGesture.Value) {
        model.handleGesture(currentImage: currentImage, value: value)
    }
    
}
