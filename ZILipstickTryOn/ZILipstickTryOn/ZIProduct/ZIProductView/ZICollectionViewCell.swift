//
//  ZICollectionViewCell.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 22/06/22.
//

import UIKit
import SDWebImage

class ZICollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var colorImage: UIImageView!
    @IBOutlet var colorLabel: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with availableColors: ZIProductAvailableColorsValue?)
    {
        let colorName = availableColors?.color ?? ""
        let swatchURL = ImageBaseUrl + (availableColors?.swatch ?? "")
        colorImage.sd_setImage(with: URL(string:swatchURL))
        colorLabel.text = colorName
    }

    static func nib() -> UINib {
        return UINib(nibName: "ZICollectionViewCell", bundle: nil)
    }
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "ZILipstickViewController", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
