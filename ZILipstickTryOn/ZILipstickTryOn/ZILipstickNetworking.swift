//
//  ZILipstickNetworking.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 17/06/22.
//

import Foundation
import UIKit


struct ZILipstickNetworking {
    
    static let sharedInstance = ZILipstickNetworking()
    let session = URLSession.shared
        
    func getData(completion:@escaping (Data)->Void, failure:@escaping (Error)->Void) {
                
        let UserURL = URL(string: userURL)!
        let dataTask = session.dataTask(with: UserURL){data,response,error in
            if let networkingError = error {
                failure(networkingError)
            }
            
               if let jsonData = data {
                    completion(jsonData)
                }
            }
        dataTask.resume()
    }
}
