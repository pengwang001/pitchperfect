//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Peng Wang on 2015-10-19.
//  Copyright © 2015 Peng Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        
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
        print("button pressed")
        RecordingInProgress.hidden = false
        StopButton.hidden = false
        RecordButton.enabled = false
      
        
    }
    @IBAction func TestTouchDown(sender: UIButton) {
        
    }

    @IBOutlet weak var RecordingInProgress: UILabel!
 
    @IBOutlet weak var StopButton: UIButton!
    
    @IBAction func StopRecording(sender: UIButton) {
        RecordingInProgress.hidden = true
    }
}

