//
//  Router.swift
//  VIPER-test
//
//  Created by Muskan Jain on 08/06/22.
//

import Foundation
import UIKit

class ZILipstickRouter: NSObject {
    
    func lipstickView(url: String) -> UIViewController {
        let view = ZILipstickViewController.init(nibName: "ZILipstickViewController", bundle: nil)
        view.fetchSwatchUrl(url: url)
        return view
    }    
}
