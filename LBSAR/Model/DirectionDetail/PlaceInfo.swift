//
//  Result.swift
//
//  Created by skj on 17.6.2020
//  Copyright (c) . All rights reserved.
//

import Foundation

struct PlaceInfo: Codable {

  enum CodingKeys: String, CodingKey {
    case website
    case formattedPhoneNumber = "formatted_phone_number"
  }

  var website: String?
  var formattedPhoneNumber: String?


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    website = try container.decodeIfPresent(String.self, forKey: .website) ?? ""
    formattedPhoneNumber = try container.decodeIfPresent(String.self, forKey:  .formattedPhoneNumber) ?? ""
  }

}
