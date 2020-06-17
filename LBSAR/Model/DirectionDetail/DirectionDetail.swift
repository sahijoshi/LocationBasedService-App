//
//  BaseClass.swift
//
//  Created by skj on 17.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DirectionDetail: Codable {

  enum CodingKeys: String, CodingKey {
    case result
  }

  var result: PlaceInfo?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    result = try container.decodeIfPresent(PlaceInfo.self, forKey: .result)
  }

}
