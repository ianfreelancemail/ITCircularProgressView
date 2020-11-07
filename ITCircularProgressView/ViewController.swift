//
//  ViewController.swift
//  ITCircularProgressView
//
//  Created by Ian Talisic on 07/11/2020.
//

import UIKit

class ViewController: UIViewController {
    var progressView: CircularProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let frame = CGRect(x: self.view.bounds.midX - 100, y: self.view.bounds.midY - 100, width: 200, height: 200)
        progressView = CircularProgressView(frame: frame)
        progressView?.percentage = 50
        
        self.view.addSubview(progressView!)
        
        
        
        progressView?.progressColor = UIColor.systemRed
    }


}

