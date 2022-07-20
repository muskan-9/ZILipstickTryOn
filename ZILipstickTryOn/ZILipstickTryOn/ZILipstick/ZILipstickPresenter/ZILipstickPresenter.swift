//
//  Presenter.swift
//  VIPER-test
//
//  Created by Muskan Jain on 08/06/22.
//

import Foundation
import ARKit

class ZILipstickPresenter: NSObject {
    
    var interactor = ZILipstickInteractor()
    
    func getUrlFromView(url: String) -> UIColor {
        if url == "" {
            print("url not recieved in presenter")
            return .systemGray
        }
        
        else {
            interactor.colorEntity.swatchUrl = url
            return  interactor.getLipstickColor(url: url)
        }
    }
    
    func sendColorToView(completion: @escaping (UIColor)->Void) {
        if let color = interactor.colorEntity.lipstickColor {
            completion(color)
        }
    }
    
}
