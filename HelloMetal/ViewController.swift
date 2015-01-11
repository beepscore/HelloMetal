//
//  ViewController.swift
//  HelloMetal
//
//  Created by Steve Baker on 1/11/15.
//  Copyright (c) 2015 Beepscore LLC. All rights reserved.
//

import UIKit
import Metal

class ViewController: UIViewController {

    // device must be an optional, because it's not set in init.
    // Use ! to implicitly unwrap.
    var device: MTLDevice! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        device = MTLCreateSystemDefaultDevice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

