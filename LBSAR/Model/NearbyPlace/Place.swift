//
//  BaseClass.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Place: Codable {

  enum CodingKeys: String, CodingKey {
    case results
  }

  var results: [Results]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([Results].self, forKey: .results)
  }

}
