//
//  KKMusicTool.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import AVFoundation

let kPlayerDidFinishedNotification = "kPlayerDidFinishedNotification"

class KKMusicTool: NSObject {
    var player:AVAudioPlayer?
    var volume : Float = 1.0
    
    
    override init() {
        super.init()
        //单例+初始化后台播放模式
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
        } catch {
            print("session fail")
            return
        }
    }
    /*
     Private 基本操作
     */
    func playMusicWithFileName(_ musicName:String?){
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else { return }
        if player?.url == url {
            player?.play()
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.enableRate = true
            player?.prepareToPlay()
            player?.volume = volume
            player?.play()
            
        } catch  {
            print("play music with name fail")
            return
        }
    }
    
    func playMusic(){
        player?.play()
    }
    func pauseMusic(){
        player?.pause()
    }
    func stopMusic(){
        player?.currentTime = 0
        player?.stop()
    }
    
    func playRate(_ value:Float){//设置播放速率
        player?.rate = value
    }
    func volume(_ value:Float){//音量
        volume = value
        player?.volume = volume
    }
    func seekToTime(_ time:TimeInterval){//跳转
        player?.currentTime = time
    }
    
}

extension KKMusicTool:AVAudioPlayerDelegate{

    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: Notification.Name(rawValue:kPlayerDidFinishedNotification), object: nil)
    }
}
