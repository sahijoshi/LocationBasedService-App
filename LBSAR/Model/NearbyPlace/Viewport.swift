//
//  Viewport.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Viewport: Codable {

  enum CodingKeys: String, CodingKey {
    case northeast
    case southwest
  }

  var northeast: Northeast?
  var southwest: Southwest?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    northeast = try container.decodeIfPresent(Northeast.self, forKey: .northeast)
    southwest = try container.decodeIfPresent(Southwest.self, forKey: .southwest)
  }

}
