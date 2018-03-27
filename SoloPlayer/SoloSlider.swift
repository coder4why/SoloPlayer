//
//  SoloSlider.swift
//  SoloPlayer
//
//  Created by qwer on 2018/3/27.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

class SoloSlider: UIView {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    
    //滑动：
    var sliderValue:Float = 0{
        didSet{
            self.slider.setValue(sliderValue, animated: true)
        }
    }
    //时间：
    var second:NSInteger = 0{
        didSet{
            let sec:NSInteger = second%60
            let min:NSInteger = second/60
            self.timeLabel.text = String.init(format: "%02ld:%02ld", min,sec)
        }
    }
    
    
    static func getSlider()->SoloSlider{
        
        let sliderView:SoloSlider = Bundle.main.loadNibNamed("SoloSlider", owner: nil, options: [:])?.last as! SoloSlider
        
        return sliderView
        
    }
    
    fileprivate func setThumbImage()->UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: 14, height: 14))
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.blue.cgColor)
        context!.setStrokeColor(UIColor.blue.cgColor)
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 14, height: 14))
        context!.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       
        return image!
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.slider.setThumbImage(self.setThumbImage(), for: .normal)
    }
    
}
