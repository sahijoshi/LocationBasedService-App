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
    
    static func loadNearbyPointOfInterest(location: CLLocation, radius: Int = 9000, searchKey: String = "", completion: @escaping ([Results]?) -> ()) {
        let router = Router.loadPointOfInterest(location: location, radius: 9000, searchKey: "bank")
        
        NetworkRequest.request(router){ place in
            completion(place.results)
        }
    }
    
    static func loadDetailInformationFor(_ place: Results, completion: @escaping (PlaceInfo?) -> ()) {
        let router = Router.loadDetailInformation(place: place)
        
        NetworkRequest.requestDetail(router) { directionDetail in
            completion(directionDetail.result)
        }
    }
    
}
