//
//  ViewController.swift
//  Pomodoro
//
//  Created by HongYeol Jeon on 2018. 8. 29..
//  Copyright © 2018년 HongYeol Jeon. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    var hpTimer: Timer!
    var totalTime = 5
    
    var playBtnFlag = 0;
    
    let TIMERPLAYING = 1
    let TIMERPAUSE = 0
    
    
    @IBAction func playBtnOnClick(_ sender: Any) {
        if(playBtnFlag == TIMERPAUSE){
            playButton.isHidden = false
            playButton.setImage(UIImage(named: "pause.png"), for: .normal)
            playButton.tintColor = UIColor.black
            playButton.frame.origin = CGPoint(x: 80, y: 295)
            
            stopButton.isHidden = false
            stopButton.setImage(UIImage(named: "stop.png"), for: .normal)
            stopButton.tintColor = UIColor.black
            stopButton.frame.origin = CGPoint(x: 200, y: 295)
            
            startTimer()
            
            playBtnFlag = TIMERPLAYING
        }else{
            playButton.isHidden = false
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
            playButton.tintColor = UIColor.black
            playButton.frame.origin = CGPoint(x: 80, y: 295)
            
            stopButton.isHidden = false
            stopButton.setImage(UIImage(named: "stop.png"), for: .normal)
            stopButton.tintColor = UIColor.black
            stopButton.frame.origin = CGPoint(x: 200, y: 295)
            
            stopTimer()
            
            playBtnFlag = TIMERPAUSE
        }
    }
    
    @IBAction func stopBtnOnClick(_ sender: Any) {
        playButton.isHidden = false
        playButton.frame.origin = CGPoint(x: 140, y: 295)
        playButton.setImage(UIImage(named: "play.png"), for: .normal)
        playButton.tintColor = UIColor.black
        playButton.isEnabled = true
        
        stopButton.isHidden = true
        stopButton.setImage(UIImage(named: "stop.png"), for: .normal)
        stopButton.tintColor = UIColor.black
        
        stopTimer()
        
        playBtnFlag = TIMERPAUSE
        
        totalTime = 5
        setTimerLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttonImgLoad()
        
        setTimerLabel()
    }
    
    func startTimer() {
        hpTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime != 0 {
            totalTime -= 1
        } else {
            playButton.isHidden = false
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
            playButton.tintColor = UIColor.black
            playButton.frame.origin = CGPoint(x: 80, y: 295)
            playButton.isEnabled = false
            
            stopButton.isHidden = false
            stopButton.setImage(UIImage(named: "stop.png"), for: .normal)
            stopButton.tintColor = UIColor.black
            stopButton.frame.origin = CGPoint(x: 200, y:295)
            playBtnFlag = TIMERPLAYING

            stopTimer()
            callAlarm()
        }
        
        setTimerLabel()
    }

    func stopTimer() {
        hpTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setTimerLabel() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 64)
        ]
        
        timerLabel.textAlignment = .center
        timerLabel.attributedText = NSMutableAttributedString(string: "\(timeFormatted(totalTime))", attributes: strokeTextAttributes)
    }
    
    func buttonImgLoad() {
        playButton.frame.origin = CGPoint(x: 140, y: 295)
        playButton.setImage(UIImage(named: "play.png"), for: .normal)
        playButton.tintColor = UIColor.black
        
        stopButton.isHidden = true
        stopButton.setImage(UIImage(named: "stop.png"), for: .normal)
        stopButton.tintColor = UIColor.black
        
        settingButton.frame.origin = CGPoint(x: 325, y: 80)
        settingButton.setImage(UIImage(named: "setting.png"), for: .normal)
        settingButton.tintColor = UIColor.black
    }
    
    func callAlarm() {
        AudioServicesPlaySystemSound(4095)
    }
}

