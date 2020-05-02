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
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//        
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        
//        sceneView.scene = SCNScene(named: "art.scnassets/StickfigureBODY.scn")!
//
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            fatalError()
        }
        
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        geometry.materials.first?.diffuse.contents = UIColor.yellow
        
        let planeNode = SCNNode(geometry: geometry)
        
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0, 0)
        
        DispatchQueue.main.async {
            node.addChildNode(planeNode)
        }
    }
}
