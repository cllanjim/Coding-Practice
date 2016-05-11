//
//  ViewController.swift
//  BullsEye
//
//  Created by SketchK on 15/3/9.
//  Copyright (c) 2015年 SketchK. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation



class ViewController: UIViewController {
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel:UILabel!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var roundLabel:UILabel!

    
    var currentValue:Int = 50
    var targetValue:Int = 0
    var score:Int = 0
    var round:Int = 0
    var audioPlayer:AVAudioPlayer!
    
    
    func startNewRound(){
    
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    
    override func viewDidLoad() {
        //播放背景音乐
        playBgMusic()
        
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    
        //set style of slider
        
        let thumblmageNormal = UIImage(named:"SliderThumb-Normal")
        slider.setThumbImage(thumblmageNormal, forState: .Normal)
        
        let thumblmageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumblmageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SlidertrackLeft")
        
        let trackLeftResizable = trackLeftImage?.resizableImageWithCapInsets(insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        
        let trackRightResizable = trackRightImage?.resizableImageWithCapInsets(insets)
        
        slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        
        
        //currentValue = lroundf(slider.value)
        
        //targetValue = 1 + Int(arc4random_uniform(100))
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert(){
    
        let difference = abs(targetValue - currentValue)
        
        var points = 100 - difference
        
        
        
        var title:String
        
        if difference == 0{
            title = "完美！你可以去买彩票了！"
            points += 100
        }else if difference < 5{
            title = "这运气可以中二等奖了！"
            
            if difference == 1{
                points += 50
            }
        }else if difference < 10{
            title = "貌似还不错"
        }else{
            title = "就这水平还敢来玩耍？"
        }
        
        score += points
        
        let message = "宝贝儿，你的得分是\(points)"
    
        
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK",
            style:  .Default,
            handler: {action in
                self .startNewRound()
                self .updateLabels()
        })
        
        alert.addAction(action)
        
        presentViewController(alert,animated: true, completion: nil)

        
  }
    
    @IBAction func sliderMoved(slider: UISlider){
 //           println("滑动条的当前数值是： \(slider.value)")
        currentValue = lroundf(slider.value)
    
        }
    
    func playBgMusic(){
        
        let musicPath = NSBundle.mainBundle().pathForResource("bgmusic", ofType: "mp3")
        
        let url = NSURL(fileURLWithPath: musicPath!)
    
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
    
    @IBAction func startOver(){
        
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
        
        
    }
}
