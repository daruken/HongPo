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
    var hpTimer: Timer!
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let strokeTextAttributes: [NSAttributedStringKey: Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            .font : UIFont.boldSystemFont(ofSize: 18)
        ]

        timerLabel.attributedText = NSMutableAttributedString(string: "Hello?", attributes: strokeTextAttributes)
        startTimer()

    }
    
    func startTimer() {
        hpTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        hpTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

