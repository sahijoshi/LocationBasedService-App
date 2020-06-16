//
//  OpeningHours.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct OpeningHours: Codable {

  enum CodingKeys: String, CodingKey {
    case openNow = "open_now"
  }

  var openNow: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    openNow = try container.decodeIfPresent(Bool.self, forKey: .openNow)
  }

}
