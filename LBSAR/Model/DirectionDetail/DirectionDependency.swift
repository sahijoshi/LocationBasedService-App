//
//  DirectionDependency.swift
//  LBSAR
//
//  Created by skj on 17.6.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation
import CoreLocation

struct DirectionDependency {
    let home: HomeItem?
    let currentLocation: CLLocation?
    let place: Results?
}
