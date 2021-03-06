//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Peng Wang on 2015-11-18.
//  Copyright © 2015 Peng Darrian Wang. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var alertSound:NSURL?
    var avplayer:AVAudioPlayer!
    var ReceievedAudio:RecordedAudio?
    var audioEngine:AVAudioEngine!
    var audiofile:AVAudioFile!
  
    
    func SetupMusicFile(file: String, Type: String)
    {
        if ReceievedAudio==nil {
            print("data not ready")
        
            if let filepath = NSBundle.mainBundle().pathForResource(file, ofType: Type)
            {
                let url = NSURL(fileURLWithPath: filepath)
                
                do
                {
                    try avplayer = AVAudioPlayer(contentsOfURL: url)
                
                }
                catch
                {}
     
            }
        
        }else{
            try! avplayer = AVAudioPlayer(contentsOfURL: ReceievedAudio!.filePathUrl)
            try! audiofile = AVAudioFile(forReading: ReceievedAudio!.filePathUrl)
        }

        audioEngine = AVAudioEngine()
        
        
    }
    
  
    
    func PlaySoundAtRate(rate: Float) {
        avplayer.enableRate = true
        avplayer.rate = rate
        avplayer.stop()
        avplayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetupMusicFile("movie_quote", Type: "mp3")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySound(sender: UIButton) {
        PlaySoundAtRate(0.5)    }

    @IBAction func PlaySoundFast(sender: UIButton) {
        PlaySoundAtRate(2)    }
    
    @IBAction func StopPlaySound(sender: UIButton) {
        avplayer.stop()
        audioEngine.stop()
    }
    
    func PlaySoundWithVariablePitch(pitch: Float) {
        avplayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        let pitchPlayer = AVAudioPlayerNode()
       
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        audioEngine.attachNode(pitchPlayer)
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: audiofile.processingFormat)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: audiofile.processingFormat)
        
        pitchPlayer.scheduleFile(audiofile, atTime: nil, completionHandler: nil)
        
        
        try! audioEngine.start()
        pitchPlayer.play()


    }
    
    @IBAction func PlayDarthVaderAudio(sender: UIButton) {
        PlaySoundWithVariablePitch(-1000)
    }
    @IBAction func PlayChipmunkAudio(sender: UIButton) {
        
       PlaySoundWithVariablePitch(1000)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
