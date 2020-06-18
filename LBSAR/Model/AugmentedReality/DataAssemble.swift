//
//  DataAssemble.swift
//  LBSAR
//
//  Created by skj on 17.6.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation
import CoreLocation

struct DataAssemble {
    
    // Prepare data to be used for Augmented Reality and general purpose
    static func prepareData(_ pointofInterest: [Results]) -> [Place] {
        var placeArr = [Place]()
        for result in pointofInterest {
            let location = CLLocation(latitude: CLLocationDegrees((result.geometry?.location?.lat)!), longitude: CLLocationDegrees((result.geometry?.location?.lng)!))
            
            if let place = Place(identifier: "", title: "", location: location) {
                place.reference = result.reference!
                place.placeName = result.name!
                place.address = result.vicinity!
                place.rating = Double(result.rating!)
                place.userTotalRating = result.userRatingsTotal!
                if let photosArr = result.photos, let photo = photosArr.first, let photoReference = photo.photoReference {
                    place.photoReference = photoReference
                }
                if let openingHours = result.openingHours, let openNow = openingHours.openNow {
                    place.openNow = openNow
                }
                
                place.latitude = CLLocationDegrees((result.geometry?.location?.lat)!)
                place.longitude = CLLocationDegrees((result.geometry?.location?.lng)!)
                place.imageUrl = Constants.URL.baseUrl + "photo?maxwidth=400&photoreference=\(place.photoReference)&sensor=false&key=\(Constants.APIKey.googleApiKey)"
                placeArr.append(place)
            }
        }
        return placeArr
    }
}
