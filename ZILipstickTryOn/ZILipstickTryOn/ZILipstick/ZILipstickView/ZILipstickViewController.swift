//
//  ViewController.swift
//  VIPER-test
//
//  Created by Muskan Jain on 13/06/22.
//

import UIKit
import SceneKit
import ARKit

class ZILipstickViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var  lipstickARSCNView: ARSCNView!
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func resetTracking() {
        let configuration = ARFaceTrackingConfiguration()
        
        //provides scene lighting information to make the AR application look more realistic
        configuration.isLightEstimationEnabled = true
        
        //resets the AR tracking to the last state
        lipstickARSCNView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lipstickARSCNView.delegate = self
        lipstickARSCNView.automaticallyUpdatesLighting = true
        UIApplication.shared.isIdleTimerDisabled = true

        resetTracking()
    }
    
    func fetchSwatchUrl(url: String) {
        print(url)
        lipstickPresenter.interactor.colorEntity.lipstickColor = lipstickPresenter.getUrlFromView(url: url)
    }
    
    
    //MARK: ARSCNViewDelegate
    
    var faceAnchors: Set<ARFaceAnchor> = []
    var masks: Set<SCNNode> = []
    var lipstickPresenter = ZILipstickPresenter()

    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return nil
        }
        
        faceAnchors.insert(faceAnchor)
        
        let faceGeometry = ARSCNFaceGeometry(device: lipstickARSCNView.device!)!
        let material = faceGeometry.firstMaterial!
        material.diffuse.contents = #imageLiteral(resourceName: "wireframeTexture.png")
        
        lipstickPresenter.sendColorToView(completion: {lipstickColor in
            material.multiply.contents = lipstickColor
            print("Applied color = \(lipstickColor)")
        })
        
        material.lightingModel = .physicallyBased
        material.transparency = 0.82
        let mask = SCNNode(geometry: faceGeometry)
        masks.insert(mask)
        return mask
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        
        guard faceAnchors.contains(faceAnchor),
              masks.contains(node),
              let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            fatalError()
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
                
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        
        faceAnchors.remove(faceAnchor)
        masks.remove(node)
    }
    
    // MARK: - State Changes
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
        lipstickARSCNView.session.pause()
    }

}



