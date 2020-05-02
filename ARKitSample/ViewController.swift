//
//  ViewController.swift
//  ARKitSample
//
//  Created by 竹ノ内愛斗 on 2020/05/02.
//  Copyright © 2020 竹ノ内愛斗. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var arView: ARView!
    @IBOutlet var sceneView: ARSCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        let scene = SCNScene(named: "StickfigureBODY.scn", inDirectory: "art.scnassets")!
        
        for child in scene.rootNode.childNodes {
            virtualObjectNode.addChildNode(child)
        }

        sceneView.session.run(configuration)
    }
    
    private lazy var virtualObjectNode: SCNNode = {
        let v = SCNNode()
        return v
    }()
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            fatalError()
        }
        
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        geometry.materials.first?.diffuse.contents = UIColor.white
        
        let planeNode = SCNNode(geometry: geometry)
        
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0, 0)
        
        DispatchQueue.main.async {
            node.addChildNode(planeNode)
            node.addChildNode(self.virtualObjectNode)
        }
        
    }
}
