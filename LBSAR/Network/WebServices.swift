//
//  WebServices.swift
//  LBSAR
//
//  Created by skj on 15.6.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation
import CoreLocation

struct WebServices {
    
    static func loadNearbyPointOfInterest(location: CLLocation, radius: Int = 9000, searchKey: String = "", completion: @escaping () -> ()) {
        let location = CLLocation(latitude: 37.78583400, longitude: -122.40641700)
        let router = Router.loadPointOfInterest(location: location, radius: 9000, searchKey: "bank", apiKey: Constants.APIKey.googleApiKey)
        
        NetworkRequest.request(router)
    }
    
}
