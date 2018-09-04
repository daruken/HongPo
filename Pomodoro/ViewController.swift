//
//  ViewController.swift
//  Pomodoro
//
//  Created by HongYeol Jeon on 2018. 8. 29..
//  Copyright © 2018년 HongYeol Jeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var hpTimer: Timer!
    var totalTime = 5
    var playBtnFlag = 0;
    
    let TIMERPLAYING = 1
    let TIMERPAUSE = 0
    let TIMERSTOP = 2
    
    
    @IBAction func playBtnOnClick(_ sender: Any) {
        if(playBtnFlag == TIMERPAUSE){
            playButton.setImage(UIImage(named: "pause.png"), for: .normal)
            playButton.tintColor = UIColor.black
            startTimer()
            
            playBtnFlag = TIMERPLAYING
        }else if(playBtnFlag == TIMERPLAYING){
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
            playButton.tintColor = UIColor.black
            stopTimer()
            
            playBtnFlag = TIMERPAUSE
        }else{
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
            playButton.tintColor = UIColor.black
            totalTime = 5
            setTimerLabel()
            
            playBtnFlag = TIMERPAUSE
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playButton.setImage(UIImage(named: "play.png"), for: .normal)
        playButton.tintColor = UIColor.black
        
        setTimerLabel()
    }
    
    func startTimer() {
        hpTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime != 0 {
            totalTime -= 1
        } else {
            playButton.setImage(UIImage(named: "stop.png"), for: .normal)
            playButton.tintColor = UIColor.black
            playBtnFlag = TIMERSTOP

            stopTimer()
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
        let strokeTextAttributes: [NSAttributedStringKey: Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 64)
        ]
        
        timerLabel.textAlignment = .center
        timerLabel.attributedText = NSMutableAttributedString(string: "\(timeFormatted(totalTime))", attributes: strokeTextAttributes)
    }
}

