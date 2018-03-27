//
//  ViewController.swift
//  SoloPlayer
//
//  Created by qwer on 2018/3/27.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var playView:SoloPlayerView? = {
       
        let xx = SoloPlayerView.init(frame: CGRect.init(x: 20, y: 100, width: UIScreen.main.bounds.size.width-40, height: 200), url: "Test")
        
        return xx
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.playView!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.playView?.play()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

