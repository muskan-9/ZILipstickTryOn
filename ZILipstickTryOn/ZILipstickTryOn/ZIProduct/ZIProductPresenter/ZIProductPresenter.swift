//
//  ZIProductPresenter.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 29/06/22.
//

import Foundation
import CoreMedia

class ZIProductPresenter: NSObject {
        
    var productInteractor = ZIProductInteractor()
    
    func getDataFromInteractor(completion: @escaping (Bool)->Void, failure:@escaping (Error)->Void) {
        productInteractor.fetchData(completion: { jsonDataRecieved in
            if jsonDataRecieved == false {
                print("data not recieved from interactor to presenter")
            }
            
            else {
                completion(true)
                print("data recieved from interactor to presenter")
            }
            
        }, failure: { networkingError in
            failure(networkingError)
        })
    }
    
    func getProductName() -> String {
        return productInteractor.productEntity?.data?.summary?.name ?? "nil"
    }

    func getProductImage() -> String {
        return productInteractor.productEntity?.data?.media?.values?.first?.extraLarge ?? "nil"
    }

    func getColor() -> ZIProductAvailableColors? {
        return productInteractor.productEntity?.data?.availableColors
    }


}

