//
//  Southwest.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Southwest: Codable {

  enum CodingKeys: String, CodingKey {
    case lng
    case lat
  }

  var lng: Float?
  var lat: Float?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    lng = try container.decodeIfPresent(Float.self, forKey: .lng)
    lat = try container.decodeIfPresent(Float.self, forKey: .lat)
  }

}
