//
//  GameController.swift
//  darktennis
//
//  Created by Eric Mcallister on 18/01/2017.
//  Copyright © 2017 wttech. All rights reserved.
//

import UIKit
import CoreMotion


class GameController: UIViewController {

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var xrotLabel: UILabel!
    @IBOutlet var yrotLabel: UILabel!
    @IBOutlet var zrotLabel: UILabel!
    @IBOutlet var ball: UIImageView!
    @IBOutlet var paddle: UIButton!
    var score = 0;
    var side = 0
    var pos = 0
    var i = 40
    var vx = 0.0
    var vy = 2.0
    var vxabs = 0.0
    var vyabs = 2.0
    let screenSize = UIScreen.main.bounds
    
    let motionManager = CMMotionManager()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
//        motionManager.startMagnetometerUpdates()
//        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func update() {
        vyabs = abs(vy)
        if(i < -Int(screenSize.height)){
            vy = vyabs
        }
        print(i)
        i = i + Int(vy)
        print("butts: \(i)")
        if(i > Int(screenSize.height)){
            score = 0
            self.scoreLabel.text = "\(score)"
            i = 0
        }
        
        ball.frame = CGRect(x: screenSize.width/2, y: CGFloat(i), width: ball.frame.size.width, height: ball.frame.size.height)
        
//        if let accelerometerData = motionManager.accelerometerData {
//            print(accelerometerData)
//        }
        let gyroData = motionManager.gyroData
        if (gyroData != nil) {
//            print(Double(round(100*(gyroData?.rotationRate.x)!)/100))
            
            let xLabel : String = String("x: \(gyroData!.rotationRate.x)")
            let yLabel : String = String("y: \(gyroData!.rotationRate.y)")
            let zLabel : String = String("z: \(gyroData!.rotationRate.z)")
            
            xrotLabel.text = xLabel
            yrotLabel.text = yLabel
            zrotLabel.text = zLabel
            
            
            let xnum = gyroData!.rotationRate.x
            
            if xnum < -2.0{
                if i > Int(screenSize.height)/2 - 50 && i < Int(screenSize.height)/2 + 50 && vy > 0{
                    updateScore()
                    vy = xnum
                    ball.frame = CGRect(x: screenSize.width/2, y: CGFloat(i), width: ball.frame.size.width, height: ball.frame.size.height)
                }
                
//                self.view.backgroundColor = UIColor.red
                
                
            } else if xnum < 2.0 {
                if i > Int(screenSize.height){
                    score = -1
                    updateScore()
                }
//                self.view.backgroundColor = UIColor.white
            } else{
                if i > Int(screenSize.height)/2 - 50 && i < Int(screenSize.height)/2 + 50 && vy > 0{
                    updateScore()
                    vy = -1*xnum
                    ball.frame = CGRect(x: screenSize.width/2, y: CGFloat(i), width: ball.frame.size.width, height: ball.frame.size.height)
                }
                
//                self.view.backgroundColor = UIColor.blue
            }

        }
        
        
        
        
//        if let magnetometerData = motionManager.magnetometerData {
//            print(magnetometerData)
//        }
//        if let deviceMotion = motionManager.deviceMotion {
//            print(deviceMotion)
//        }
    }
    
    func updateScore() {
        score = score + 1
        self.scoreLabel.text = "\(score)"
    }
}
