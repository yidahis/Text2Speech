//
//  NBAudioBot.swift
//  Text2Speech
//
//  Created by zhouyi on 2017/4/18.
//  Copyright © 2017年 NewBornTown, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class NBAudioBot: NSObject {
    
    fileprivate static let shareBot = NBAudioBot()
    override init() {
        super.init()
    }

    fileprivate var audioPlayer : AVAudioPlayer?
}

extension NBAudioBot{

    public class func PlayerWithURL(_ fileURL: URL ,finish: @escaping(Bool) -> Void) throws {
        
        NotificationCenter.default.addObserver(shareBot, selector: #selector(notificationBegain), name: Notification.Name(rawValue:TTSpeechManager.speechStatus.begain), object: nil)
        NotificationCenter.default.addObserver(shareBot, selector: #selector(notificationEnd), name: Notification.Name(rawValue:TTSpeechManager.speechStatus.end), object: nil)
        NotificationCenter.default.addObserver(shareBot, selector: #selector(notificationExit), name: Notification.Name(rawValue:TTSpeechManager.speechStatus.exit), object: nil)
        
        let seesion = AVAudioSession.sharedInstance()
        do {
            try seesion.setCategory(AVAudioSessionCategoryPlayback)
            try seesion.setActive(true)
        } catch let err {
            throw err
        }
        
        if let audioPlayer = shareBot.audioPlayer, audioPlayer.url == fileURL  {
            audioPlayer.play()
        }else{
            shareBot.audioPlayer?.pause()
            do {
                let player = try AVAudioPlayer(contentsOf: fileURL)
                shareBot.audioPlayer = player
                player.numberOfLoops = 9999
                player.delegate = shareBot
                player.prepareToPlay()
                player.play()
            } catch  {
                throw error
            }
        }
    }
    public class func contiuePlay(){
        if let player = shareBot.audioPlayer, player.prepareToPlay(){
            player.play()
            print("player play")
        }
    }
    public class func pasuePlay(){
        if let player = shareBot.audioPlayer , player.isPlaying{
            player.pause()
            print("player pause")
        }
    }
    
    public class func stopPlay(){
        if let player = shareBot.audioPlayer{
            player.stop()
            print("player stop")
        }
    }
}

extension NBAudioBot{
    @objc func notificationBegain(){
        NBAudioBot.pasuePlay()
    }
    @objc func notificationEnd(){
        NBAudioBot.contiuePlay()
    }
    
    @objc func notificationExit(){
        NBAudioBot.stopPlay()
    }
}

extension NBAudioBot : AVAudioPlayerDelegate{
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("播放完成")
    }
    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("audio plyer error : \(String(describing: error))",error.debugDescription)
    }
    
}

