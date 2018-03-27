//
//  SoloPlayerView.swift
//  SoloPlayer
//
//  Created by qwer on 2018/3/27.
//  Copyright © 2018年 qwer. All rights reserved.
//
import AVFoundation
import AVFoundation.AVPlayerItem
import UIKit

class SoloPlayerView: UIView {

    //播放器的item：
    private var soloPlayerItem:AVPlayerItem?
    //播放器：
    private var soloPlayer:AVPlayer?
    //播放器的layer：
    private var soloPlayerLayer:AVPlayerLayer?
    
    private lazy var sliderView:SoloSlider? = {
       
        let xx = SoloSlider.getSlider()
        return xx
        
    }()
    
    //视频的url：
    init(frame: CGRect,url:String) {
        super.init(frame: frame)
        
        self.removeObser()
        
        self.backgroundColor = UIColor.black
        guard let path = Bundle.main.path(forResource: url, ofType: "mp4") else{
            return
        }
        
        let mp4Url:URL = URL.init(fileURLWithPath: path)
        self.soloPlayerItem = AVPlayerItem.init(url: mp4Url)
        self.soloPlayer = AVPlayer.init(playerItem: self.soloPlayerItem)
        self.soloPlayerLayer = AVPlayerLayer.init(player: self.soloPlayer)
        self.soloPlayerLayer?.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
      
        self.layer.insertSublayer(soloPlayerLayer!, at: 0)
        
        self.sliderView?.frame = CGRect.init(x: 0, y: frame.size.height-20, width: frame.width, height: 20)
        
        self.addSubview(self.sliderView!)
        
        self.soloPlayerItem?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        //添加播放完成的回调；
        NotificationCenter.default.addObserver(self, selector: #selector(playFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
    //开始播放；
    func play(){
        
        self.soloPlayer?.play()
    }
    //停止播放；
    func pause(){
        
        self.soloPlayer?.pause()
        
    }
    
    //移除观察者；
    func removeObser(){
        if let _ = self.soloPlayerItem {
            self.soloPlayerItem?.removeObserver(self, forKeyPath: "status")
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "status" {
            
            if self.soloPlayerItem?.status == AVPlayerItemStatus.readyToPlay{
                //添加播放倒计时；
                weak var wSelf = self
                
                self.soloPlayer?.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: nil, using: { (time) in
                    
                    let item = wSelf?.soloPlayerItem
                    let second:NSInteger = NSInteger(CMTimeGetSeconds((item?.currentTime())!))
                    let totalSec:NSInteger = NSInteger(CMTimeGetSeconds((self.soloPlayerItem?.duration)!))
                    let totals:CGFloat = CGFloat(CMTimeGetSeconds((self.soloPlayerItem?.duration)!))
                    print("当前播放时间",second,totals)
                    
                    self.sliderView?.second = totalSec-second
                    self.sliderView?.sliderValue = (Float(CGFloat(second)/totals))
                    
                })
            }
        }
        
    }
    
    //播放完成的回调：
    @objc private func playFinished(){
        
        //播放完成回到第一帧：
        self.soloPlayer?.seek(to: CMTimeMake(Int64(0), 1), completionHandler: { (BOOL) in
            print("播放完成")
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
