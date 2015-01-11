//
//  ViewController.swift
//  HelloMetal
//
//  Created by Steve Baker on 1/11/15.
//  Copyright (c) 2015 Beepscore LLC. All rights reserved.
//

import UIKit
import Metal
import QuartzCore

class ViewController: UIViewController {

    // device must be an optional, because it's not set in init.
    // Use ! to implicitly unwrap.
    var device: MTLDevice! = nil
    var metalLayer: CAMetalLayer! = nil

    let vertexData:[Float] = [
        0.0, 1.0, 0.0,
        -1.0, -1.0, 0.0,
        1.0, -1.0, 0.0
    ]

    var vertexBuffer: MTLBuffer! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        device = MTLCreateSystemDefaultDevice()

        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)

        let dataSize = vertexData.count * sizeofValue(vertexData[0])
        vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

