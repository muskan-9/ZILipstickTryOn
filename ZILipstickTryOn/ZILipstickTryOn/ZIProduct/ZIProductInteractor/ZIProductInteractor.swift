//
//  ZIProductInteractor.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 28/06/22.
//

import Foundation

class ZIProductInteractor: NSObject {
    
    var productEntity: ZIProductEntity? = nil
    
    func fetchData(completion:@escaping (Bool)->Void, failure: @escaping (Error)->Void) {
        let networking = ZILipstickNetworking()
        
        networking.getData(completion: { jsonData in
            
            let jsonDecoder = JSONDecoder.init()
            
            do {
                let jsonData = try jsonDecoder.decode(ZIProductEntity.self, from: jsonData)
                self.productEntity = jsonData
                completion(true)
            }
            catch let error {
               print(error)
            }
        },
            failure: {networkingError in
            failure(networkingError)
        })
    }
    
    func addBaseURL(url: String) -> String {
        return (ImageBaseUrl + url)
    }
}
