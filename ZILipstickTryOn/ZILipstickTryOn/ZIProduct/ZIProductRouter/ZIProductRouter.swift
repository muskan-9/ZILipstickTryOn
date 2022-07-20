//
//  ZIProductRouter.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 05/07/22.
//

import Foundation
import UIKit

class ZIProductRouter: NSObject {
    class func createModule() -> UIViewController {
        
        let view = ZIProductViewController.init(nibName: "ZIProductViewController", bundle: nil)
        return view
    }
}
