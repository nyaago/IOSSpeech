//
//  ViewController.swift
//  IOSSpeech
//
//  Created by nyaago on 2015/07/12.
//  Copyright (c) 2015年 nyaago. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet var textView: UITextView!
    @IBOutlet var speechButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var pitchSlider: UISlider!
    @IBOutlet var rateSlider: UISlider!
    
    var speechSynthesizer: AVSpeechSynthesizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doSpeech(sender: AnyObject) {
        NSLog("speech")
        if speechSynthesizer?.paused == true {
            speechSynthesizer?.continueSpeaking()
        }
        else {
            var text = textView.text
            var utterance = AVSpeechUtterance(string: text)
            var voice = AVSpeechSynthesisVoice(language: "ja_JP")
            utterance.voice = voice
            utterance.rate = rateSlider.value
            utterance.pitchMultiplier = pitchSlider.value
            utterance.preUtteranceDelay = 0.2
            speechSynthesizer?.speakUtterance(utterance)
        }
    }
    
    @IBAction func doStop(sender: AnyObject) {
        speechSynthesizer?.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }

    @IBAction func doPause(sender: AnyObject) {
        speechSynthesizer?.pauseSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    @IBAction func pitchChanged(sender: AnyObject) {
    }
    
    @IBAction func rateChanged(sender: AnyObject) {
        
    }
    
    // delegate
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didContinueSpeechUtterance utterance: AVSpeechUtterance!) {
        
        pauseButton?.enabled = true
        stopButton?.enabled = true
        speechButton?.enabled = false
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        pauseButton?.enabled = false
        stopButton?.enabled = false
        speechButton?.enabled = true
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didPauseSpeechUtterance utterance: AVSpeechUtterance!) {
        pauseButton?.enabled = false
        stopButton?.enabled = false
        speechButton?.enabled = true
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        pauseButton?.enabled = true
        stopButton?.enabled = true
        speechButton?.enabled = false

    }
    

}

