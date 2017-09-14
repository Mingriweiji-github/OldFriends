//
//  KKMusicOperationTool.swift
//  KKFriends
//
//  Created by M_Li on 2017/9/14.
//  Copyright © 2017年 M_Li. All rights reserved.
//

import UIKit
import MediaPlayer

class KKMusicOperationTool: NSObject {

    static let sharedInstance = KKMusicOperationTool()
    let musicTool = KKMusicTool()
    var musicMs = [KKMusicModel]()
    fileprivate var lastRow = -1
    fileprivate var artWork:MPMediaItemArtwork?
    fileprivate var currentIndex = -1{
        didSet{
            if currentIndex < 0 {
                currentIndex = musicMs.count - 1
            }
            if currentIndex > musicMs.count - 1{
                currentIndex = 0
            }
        }
    }
    fileprivate  var musicMessageM = KKMusicMessageModel()
    
    func getMusicWithMessage() -> KKMusicMessageModel{
        if musicMs.count == 0 {
            return musicMessageM
        }
        musicMessageM.music = musicMs[currentIndex]
        musicMessageM.totalTime = musicTool.player?.duration ?? 0
        musicMessageM.costTime = musicTool.player?.currentTime ?? 0
        musicMessageM.isPlaying = musicTool.player?.isPlaying ?? false
        return musicMessageM
    }
    //播放、并确定播放的index
    
    func playMusicWithModel(_ musicM:KKMusicModel) {
        musicTool.playMusicWithFileName(musicM.filename)
        currentIndex = musicMs.index(of: musicM)!
    }
    func playCurrentMusic(){
        let model = musicMs[currentIndex]
        playMusicWithModel(model)
    }
    func pauseCurrentMusic(){
        musicTool.pauseMusic()
    }
    
    func nextMusic(){
        currentIndex += 1
        playMusicWithModel(musicMs[currentIndex])
    }
    func preMusic(){
        currentIndex -= 1
        playMusicWithModel(musicMs[currentIndex])
    }
    
    func seekToTimeInterval(_ timeInterval:TimeInterval){
        musicTool.seekToTime(timeInterval)
    }
    func volume(_ volume:Float){
        musicTool.volume(volume)
    }
    
    func setupLockMessage(){
        let messageM = getMusicWithMessage()
        
        let musicName = messageM.music?.songname
        let singername = messageM.music?.singername
        let cost = messageM.costTime
        let total = messageM.totalTime
        
        let lrcFile = messageM.music?.lrcname
        let lrcMs = 
        
        
        
        
        
        
        
        
    }
    
}
