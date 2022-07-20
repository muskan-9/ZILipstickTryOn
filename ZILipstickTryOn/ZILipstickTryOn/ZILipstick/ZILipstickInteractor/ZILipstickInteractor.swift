//
//  Interactor.swift
//  VIPER-test
//
//  Created by Muskan Jain on 08/06/22.
//

import UIKit
import SceneKit
import ARKit
import ColorKit
import SDWebImage

class ZILipstickInteractor: NSObject {
    
    var swatchImage = UIImage()
    var colorEntity = ZILipstickColorEntity()
     
    func getLipstickColor(url: String) -> UIColor {
        
        if url != "" {
                let url = URL(string: (ImageBaseUrl + url))
                let tempImageView = UIImageView()
                tempImageView.sd_setImage(with: url)
            self.swatchImage = tempImageView.image ?? UIImage()
        }
        
        print("colorEntity swatch image = \(String(describing: swatchImage.size))")
        
        let extractedColor = swatchImage.getPixelColor(pos: CGPoint(x: swatchImage.size.width*0.5 , y: swatchImage.size.height*0.5)) ?? .systemRed
        print("extracted color in interactor =  \(extractedColor)")
        
        return extractedColor
    }
    
}

extension UIImage {
   func getPixelColor(pos: CGPoint) -> UIColor? {
     guard let cgImage = self.cgImage,
        let dataProvider = cgImage.dataProvider else {
       return nil
     }
       
     let pixelData = dataProvider.data
     let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
     let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
     let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
     let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
     let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
     let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
       
       print (UIColor(red: r, green: g, blue: b, alpha: a))
     return UIColor(red: r, green: g, blue: b, alpha: a)
   }
 }
