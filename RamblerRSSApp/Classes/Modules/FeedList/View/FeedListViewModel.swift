//
//  FeedListViewModel.swift
//  RamblerRSSApp
//
//  Created by Andrey Egorov on 2/8/16.
//  Copyright © 2016 Andrey Egorov. All rights reserved.
//

import Foundation
import UIKit

class FeedListViewModel : NSObject {
    
    var title: String
    var detailInformation: String
    var image: UIImage
    
    init(title: String, detailInformation: String, image: UIImage) {
        self.title = title
        self.detailInformation = detailInformation
        self.image = image
    }
}