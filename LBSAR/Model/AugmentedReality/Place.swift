//
//  Place.swift
//  LBSAR
//
//  Created by skj on 9.3.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import UIKit
import CoreLocation
import HDAugmentedReality

class Place: ARAnnotation {
    var reference = ""
    var placeName = ""
    var address = ""
    var rating = 0.0
    var userTotalRating = 0
    var photoReference = ""
    var openNow = true
    var imageUrl = ""
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var curLocation: CLLocation?
}
