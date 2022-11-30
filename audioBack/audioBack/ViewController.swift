//
//  ViewController.swift
//  audioBack
//
//  Created by cumulations on 30/11/22.
//

import UIKit
import AVFoundation
import AVKit
import AVFAudio
import Combine
class ViewController: UIViewController {
    enum playorpause {
        case play
        case pause
    }
    var check = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
    }

    @IBAction func playbutton(_ sender: Any) {
        if(check){
            MusicHandler.sharedInstance.pause()
            check = false
        }
        else{
            MusicHandler.sharedInstance.play()
            check = true
        }
    }
    
}

class MusicHandler{
    var player:AVQueuePlayer?
    var timeobserver:Any?
    static var sharedInstance = MusicHandler()
    func play(){
        let path = Bundle.main.path(forResource: "blankMusic", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
            try! AVAudioSession.sharedInstance().setCategory(.playback)
            self.player = AVQueuePlayer(url: url)
            self.player?.actionAtItemEnd = .none
            timeobserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 100), queue: nil, using: { Time in
                print(Time)
            })
            player?.play()
        }
    }
    func pause(){
        if(timeobserver != nil){
            player?.pause()
            player?.removeTimeObserver(timeobserver)
            timeobserver = nil
        }
    }
}
