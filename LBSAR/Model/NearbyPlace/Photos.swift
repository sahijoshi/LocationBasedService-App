//
//  Photos.swift
//
//  Created by skj on 16.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Photos: Codable {

  enum CodingKeys: String, CodingKey {
    case photoReference = "photo_reference"
    case htmlAttributions = "html_attributions"
    case height
    case width
  }

  var photoReference: String?
  var htmlAttributions: [String]?
  var height: Int?
  var width: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    photoReference = try container.decodeIfPresent(String.self, forKey: .photoReference)
    htmlAttributions = try container.decodeIfPresent([String].self, forKey: .htmlAttributions)
    height = try container.decodeIfPresent(Int.self, forKey: .height)
    width = try container.decodeIfPresent(Int.self, forKey: .width)
  }

}
