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

    var pipelineState: MTLRenderPipelineState! = nil

    var commandQueue: MTLCommandQueue! = nil

    var timer: CADisplayLink! = nil

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

        // configure render pipeline
        let defaultLibrary = device.newDefaultLibrary()
        let fragmentProgram = defaultLibrary!.newFunctionWithName("basic_fragment")
        let vertexProgram = defaultLibrary!.newFunctionWithName("basic_vertex")

        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        // error "objectAtIndexedSubscript is unavailable: use subscripting"
        // pipelineStateDescriptor.colorAttachments.objectAtIndexedSubscript(0).pixelFormat = .BGRA8Unorm
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm

        var pipelineError: NSError?
        pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor,
            error: &pipelineError)
        if pipelineState == nil {
            println("Failed to create pipeline state, error \(pipelineError)")
        }

        commandQueue = device.newCommandQueue()

        timer = CADisplayLink(target: self, selector: Selector("gameloop"))
        timer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func render() {
        var drawable = metalLayer.nextDrawable()

        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0,
            green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)

        let commandBuffer = commandQueue.commandBuffer()
    }
    
    func gameloop() {
        autoreleasepool {
            self.render()
        }
    }
    
}

