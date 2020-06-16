//
//  Geometry.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Geometry: Codable {

  enum CodingKeys: String, CodingKey {
    case location
    case viewport
  }

  var location: Location?
  var viewport: Viewport?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    location = try container.decodeIfPresent(Location.self, forKey: .location)
    viewport = try container.decodeIfPresent(Viewport.self, forKey: .viewport)
  }

}
