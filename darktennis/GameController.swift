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

    @IBOutlet var xrotLabel: UILabel!
    @IBOutlet var yrotLabel: UILabel!
    @IBOutlet var zrotLabel: UILabel!
    
    
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
//        if let accelerometerData = motionManager.accelerometerData {
//            print(accelerometerData)
//        }
        let gyroData = motionManager.gyroData
        if (gyroData != nil) {
            print(Double(round(100*(gyroData?.rotationRate.x)!)/100))
            
            let xLabel : String = String("x: \(gyroData!.rotationRate.x)")
            let yLabel : String = String("y: \(gyroData!.rotationRate.y)")
            let zLabel : String = String("z: \(gyroData!.rotationRate.z)")
            
            xrotLabel.text = xLabel
            yrotLabel.text = yLabel
            zrotLabel.text = zLabel
            
            
            let xnum = gyroData!.rotationRate.x
            
            if xnum < -2.0{
                self.view.backgroundColor = UIColor.red
            } else if xnum < 2.0 {
                self.view.backgroundColor = UIColor.white
                
            } else{
                self.view.backgroundColor = UIColor.blue
            }

        }
        
        
//        if let magnetometerData = motionManager.magnetometerData {
//            print(magnetometerData)
//        }
//        if let deviceMotion = motionManager.deviceMotion {
//            print(deviceMotion)
//        }
    }
}
