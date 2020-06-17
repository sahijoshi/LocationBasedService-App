//
//  NetworkRequest.swift
//  LBSAR
//
//  Created by skj on 15.6.2020.
//  Copyright © 2020 skj. All rights reserved.
//

import Foundation

struct NetworkRequest {
    
    static func request(_ route: Router, completion: @escaping (Place) -> () ) {
        let request =  route.asURLRequest()
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let place = try JSONDecoder().decode(Place.self, from: data)
                completion(place)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        dataTask.resume()
    }
    
    static func requestDetail(_ route: Router, completion: @escaping (DirectionDetail) -> () ) {
        let request =  route.asURLRequest()
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                let directionDetail = try JSONDecoder().decode(DirectionDetail.self, from: data)
                completion(directionDetail)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }

}
