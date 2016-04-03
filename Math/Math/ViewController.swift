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
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.userInput.delegate = self
        
        self.nextNumbers()
        
        
    }
    
    
    func timerResult() {
        
        sec++
        
        
        if min == 99 && sec == 59 {
            
            
            let alert = UIAlertController (title: "Timer restart!", message: nil, preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            self.sec = 0
            self.min = 0
            
        }

        
        if sec == 60 {
            
            min++
            sec = 0
            
        }
        
        
//        switch sec {
//            
//        case 0: secDisplay = "00"
//        case 1: secDisplay = "01"
//        case 2: secDisplay = "02"
//        case 3: secDisplay = "03"
//        case 4: secDisplay = "04"
//        case 5: secDisplay = "05"
//        case 6: secDisplay = "06"
//        case 7: secDisplay = "07"
//        case 8: secDisplay = "08"
//        case 9: secDisplay = "09"
//        default: secDisplay = String(sec)
//            
//        }
//        
//        
//        switch min {
//            
//        case 0: minDisplay = "00"
//        case 1: minDisplay = "01"
//        case 2: minDisplay = "02"
//        case 3: minDisplay = "03"
//        case 4: minDisplay = "04"
//        case 5: minDisplay = "05"
//        case 6: minDisplay = "06"
//        case 7: minDisplay = "07"
//        case 8: minDisplay = "08"
//        case 9: minDisplay = "09"
//        default: minDisplay = String(min)
//            
//        }
        
        // Shorter way:
        
        self.secDisplay = String(format: "%02d", sec)
        self.minDisplay = String(format: "%02d", min)

        
        timeLabel.text = "\(minDisplay):\(secDisplay)"
   
            
        
    }
    
    @IBAction func start(sender: AnyObject) {
        
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerResult"), userInfo: nil, repeats: true)
        
    }

    @IBAction func pause(sender: AnyObject) {
        
        timer.invalidate()
        
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
        
        
        
        if let userAnswer = userInput.text {
            
            let check: Bool
            let title: String
            let actionTitle: String
            
           
            if userAnswer == String (self.result){
                
                right++
                
                rightNumber.text = String(self.right)
                
                title = "Correct!"
               
                userInput.text = ""
                
                check = true
                
                actionTitle = "Continue"
                
                
            } else if userAnswer == "" {
                
                title = "Please, enter a whole number!"
                
                actionTitle = "Continue"
                
                check = false
                
            } else {
                
                wrong++
                
                wrongNumber.text = String(self.wrong)
                
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

