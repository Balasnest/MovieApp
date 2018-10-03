//
//  APIHelper.swift
//  PlacesApp
//
//  Created by Sumit Ghosh on 29/09/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit


class APIHelper: NSObject {
    static let sharedInstance = APIHelper()
    
    func getPlaceData(complitionHandler: @escaping(MovieData?,Error?) -> Void) -> Void {
        let Url = URL(string: "\(NetworkConfiguration.BASE_URL)\(NetworkConfiguration.API_KEY)")
        
        URLSessionManager.shared.getRequest(with: Url!) { (data, error) in
            if error != nil {
                complitionHandler(nil, error)
            } else {
                do {
                    let response = try JSONDecoder().decode(MovieData.self, from: data! as Data)
                    complitionHandler(response, error)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
