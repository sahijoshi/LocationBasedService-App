//
//  Results.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Results: Codable {

  enum CodingKeys: String, CodingKey {
    case icon
    case id
    case openingHours = "opening_hours"
    case types
    case userRatingsTotal = "user_ratings_total"
    case plusCode = "plus_code"
    case reference
    case vicinity
    case scope
    case placeId = "place_id"
    case photos
    case name
    case rating
    case geometry
    case businessStatus = "business_status"
  }

  var icon: String?
  var id: String?
  var openingHours: OpeningHours?
  var types: [String]?
  var userRatingsTotal: Int?
  var plusCode: PlusCode?
  var reference: String?
  var vicinity: String?
  var scope: String?
  var placeId: String?
  var photos: [Photos]?
  var name: String?
  var rating: Float?
  var geometry: Geometry?
  var businessStatus: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    icon = try container.decodeIfPresent(String.self, forKey: .icon)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    openingHours = try container.decodeIfPresent(OpeningHours.self, forKey: .openingHours)
    types = try container.decodeIfPresent([String].self, forKey: .types)
    userRatingsTotal = try container.decodeIfPresent(Int.self, forKey: .userRatingsTotal)
    plusCode = try container.decodeIfPresent(PlusCode.self, forKey: .plusCode)
    reference = try container.decodeIfPresent(String.self, forKey: .reference)
    vicinity = try container.decodeIfPresent(String.self, forKey: .vicinity)
    scope = try container.decodeIfPresent(String.self, forKey: .scope)
    placeId = try container.decodeIfPresent(String.self, forKey: .placeId)
    photos = try container.decodeIfPresent([Photos].self, forKey: .photos)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    rating = try container.decodeIfPresent(Float.self, forKey: .rating)
    geometry = try container.decodeIfPresent(Geometry.self, forKey: .geometry)
    businessStatus = try container.decodeIfPresent(String.self, forKey: .businessStatus)
  }

}
