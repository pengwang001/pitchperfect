//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Peng Wang on 2015-10-19.
//  Copyright © 2015 Peng Wang. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audiorecorder:AVAudioRecorder!
    var recordingfilePath:NSURL!
    var recordedFile:RecordedAudio!
    
    func SetupRecordingfile() {
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        let recordingName = "myvoice.wav" as String
        let pathArray = [dirPath,recordingName]
        recordingfilePath = NSURL.fileURLWithPathComponents(pathArray)
        print(recordingfilePath)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SetupRecordingfile()
        
    }
    
    @IBOutlet weak var RecordButton: UIButton!
    override func viewWillAppear(animated: Bool) {
        StopButton.hidden = true
        RecordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func RecordAudio(sender: UIButton) {
       
        RecordingInProgress.hidden = false
        StopButton.hidden = false
        RecordButton.enabled = false
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audiorecorder = AVAudioRecorder(URL: recordingfilePath, settings: [:])
        audiorecorder.meteringEnabled = true
        audiorecorder.delegate = self
        audiorecorder.prepareToRecord()
        audiorecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            recordedFile = RecordedAudio()
            recordedFile.filePathUrl = recorder.url
            recordedFile.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier("StopRecording", sender: recordedFile)
        }else{
            print("Recording was not successful!")
            StopButton.hidden = true
            RecordButton.enabled = true
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "StopRecording") {
            let TargetViewController:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data:RecordedAudio = sender as! RecordedAudio
            TargetViewController.ReceievedAudio = data
            
        }
    }
    
    @IBAction func TestTouchDown(sender: UIButton) {
        
    }

    @IBOutlet weak var RecordingInProgress: UILabel!
 
    @IBOutlet weak var StopButton: UIButton!
    
    @IBAction func StopRecording(sender: UIButton) {
        RecordingInProgress.hidden = true
        audiorecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
}

