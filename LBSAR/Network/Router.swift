//
//  Request.swift
//  LBSAR
//
//  Created by skj on 15.6.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation
import CoreLocation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

protocol EndPointType {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
}

protocol URLConverter {
    func asURLRequest() throws -> URLRequest
}

enum Router: EndPointType, URLConverter {
    case loadPointOfInterest(location: CLLocation, radius: Int, searchKey: String)
    case loadDetailInformation(place: Place)

    var baseURL: String {
        return Constants.URL.baseUrl
    }
    
    var method: HTTPMethod {
        switch self {
        case .loadPointOfInterest, .loadDetailInformation: return .get
        }
    }
    
    var path: String {
        switch self {
        case .loadPointOfInterest(let location, let radius, let searchKey):
            return "nearbysearch/json?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=\(radius)&sensor=true&types=\(searchKey)&key=\(Constants.APIKey.googleApiKey)"
            
        case .loadDetailInformation(let place):
                return "details/json?reference=\(place.reference)&sensor=true&key=\(Constants.APIKey.googleApiKey)"
        }
    }
    
    func asURLRequest() -> URLRequest {
        let baseUrl = URL(string: baseURL)
        let url = URL(string: (baseUrl?.appendingPathComponent(path).absoluteString.removingPercentEncoding)!)
        var urlRequest = URLRequest(url: url!, timeoutInterval: TimeInterval(10 * 1000))

        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
    
}
