//
//  ZIProductViewController.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 20/06/22.
//

import UIKit
import SDWebImage


class ZIProductViewController: UIViewController {
    
    
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var colorCollectionView: UICollectionView!
    @IBOutlet private weak var ZIlogo: UIImageView!
    @IBOutlet private weak var colorsLabel: UILabel!
    
    let productPresenter = ZIProductPresenter()
    let lipstickRouter = ZILipstickRouter()
    let productRouter = ZIProductRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productPresenter.getDataFromInteractor(completion: { dataRecieved in
            if dataRecieved == false {
                print("Data not recieved from presenter to View")
            }
            else {
            print("Data recieved from presenter to View")
                DispatchQueue.main.async {
                    self.productName.text = self.productPresenter.getProductName()
                    let imageURL =  self.productPresenter.productInteractor.addBaseURL(url: self.productPresenter.getProductImage())
                    self.productImage.sd_setImage(with: URL(string: imageURL))
                                        
                    self.colorCollectionView.reloadData()
                }
            }
        }, failure: { networkingError in
            DispatchQueue.main.async {
                self.displayAlertController(error: networkingError)
            }
        })
        
        configureColorCollectionView()

    }
    
    
    func configureColorCollectionView() {
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        ZIlogo.image = #imageLiteral(resourceName: "zivame_logo.png")
                                     
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        colorCollectionView.collectionViewLayout = layout
        
        colorCollectionView.register(ZICollectionViewCell.nib(), forCellWithReuseIdentifier: "collectionViewCell")
    }
    
    func displayAlertController(error: Error) {
        
        let blurEffect = UIBlurEffect(style: .light)
         let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
         blurVisualEffectView.frame = view.bounds
        
        
        let alertController = UIAlertController(title: "Networking Error", message: error.localizedDescription, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
             blurVisualEffectView.removeFromSuperview()
         }))
        
        self.view.addSubview(blurVisualEffectView)
        self.present(alertController, animated: true, completion: nil)
    }

}


extension ZIProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productPresenter.getColor()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! ZICollectionViewCell
        
        cell.configure(with: self.productPresenter.getColor()?.values?[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let swatchURL = self.productPresenter.getColor()?.values?[indexPath.row].swatch ?? ""
        let lipstickViewController = lipstickRouter.lipstickView(url: swatchURL)

        self.modalPresentationStyle = .fullScreen
        self.present(lipstickViewController, animated: true, completion: nil)
        
    }
}

extension ZIProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 80)
    }
}


