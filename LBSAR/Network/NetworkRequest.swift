//
//  NetworkRequest.swift
//  LBSAR
//
//  Created by skj on 15.6.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation

struct NetworkRequest {
    
    static func request(_ route: Router) {
        let request =  route.asURLRequest()
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let results = try JSONDecoder().decode(Place.self, from: data)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        dataTask.resume()
    }
}
