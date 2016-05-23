//
//  ViewController.swift
//  Math
//
//  Created by Kristina Bogomolova on 3/3/16.
//  Copyright © 2016 FoxyLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var right = 0
    var wrong = 0
    
    var firstN: Int = 0
    var secondN: Int = 0
    var result: Int = 0
    
    var timer = NSTimer()
    var sec = 0
    var min = 0
    var secDisplay = ""
    var minDisplay = ""
    
    var posNeg = 0
    var sign = ""
    
    @IBOutlet weak var task: UILabel!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var rightNumber: UILabel!
    @IBOutlet weak var wrongNumber: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInput.delegate = self
        self.nextNumbers()
        self.checkButton.layer.cornerRadius = 5
    }
        
    func timerResult() {
        self.sec += 1
        if self.min == 99 && self.sec == 59 {
            
            let alert = UIAlertController (title: "Timer restart!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            self.sec = 0
            self.min = 0
        }
        
        if self.sec == 60 {
            self.min += 1
            self.sec = 0
        }
        
        self.secDisplay = String(format: "%02d", self.sec)
        self.minDisplay = String(format: "%02d", self.min)
        
        self.timeLabel.text = "\(self.minDisplay):\(self.secDisplay)"
    }
    
    @IBAction func start(sender: AnyObject) {
        self.timer.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.timerResult), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(sender: AnyObject) {
        self.timer.invalidate()
    }
    
    func nextNumbers () {
        
        self.posNeg = Int(arc4random_uniform(1001))
        if self.posNeg <= 500 {
            self.sign = "-"
        } else {
            self.sign = "+"
        }
        
        self.firstN = Int(arc4random_uniform(1001))
        self.secondN = Int(arc4random_uniform(1001))
        
        if self.sign == "-" {
            if self.firstN < self.secondN {
                let temp = self.firstN
                self.firstN = self.secondN
                self.secondN = temp
                self.result = self.firstN - self.secondN
            } else {
                self.result = self.firstN - self.secondN
            }
        } else {
            self.result = self.firstN + self.secondN
        }
        
        self.task.text = String ("\(self.firstN) \(sign) \(self.secondN)")
    }
    
    @IBAction func checkAnswer(sender: AnyObject) {
        
        if let userAnswer = self.userInput.text {
            let check: Bool
            let title: String
            let actionTitle: String
            
            if userAnswer == String (self.result){
                self.right += 1
                self.rightNumber.text = String(self.right)
                title = "Correct!"
                self.userInput.text = ""
                check = true
                actionTitle = "Continue"
                
            } else if userAnswer == "" {
                title = "Please, enter a whole number!"
                actionTitle = "Continue"
                check = false
                
            } else {
                self.wrong += 1
                self.wrongNumber.text = String(self.wrong)
                title = "Wrong!"
                check = false
                actionTitle = "Try again"
            }
            
            let alert = UIAlertController (title: title, message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: .Default, handler: { (myActionParameter) -> Void in
                
                if check {
                    self.nextNumbers()
                }
            } )
            )
            self.userInput.resignFirstResponder()
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


