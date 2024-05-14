//
//  ViewController.swift
//  Consumation
//
//  Created by manfred kohl on 16/04/2024.
//

import UIKit

class ViewController: UIViewController {
    var powerManager = PowerManager()
    var timer = Timer()
    @IBOutlet var SolarPower: UILabel!
    
    @IBOutlet var EnelPower: UILabel!
    @IBOutlet var Total: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        powerManager.delegate = self
         
         
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            self.updatePowerReading()
            })
        }

        func updatePowerReading(){
            powerManager.fetchPower(select: 0)
            
            powerManager.fetchPower(select:1)
         
        
         
    }


}
extension   ViewController: PowerManagerDelegate {
    func didUpdatePower(_ powerManagerManager:PowerManager, power: PowerModel) {
        DispatchQueue.main.async {
             
            
            if (power.solar != ""){
                self.SolarPower.text = power.solar
                self.SolarPower.textColor=UIColor.green
            }
             
            if (power.enel != ""){self.EnelPower.text = power.enel}
            self.Total.text=power.totalConsumption
            if power.ecoMode {
                self.Total.textColor = UIColor.systemGreen
                self.EnelPower.textColor = UIColor.systemGreen
            }
            else {
                self.Total.textColor = UIColor.red
                self.EnelPower.textColor = UIColor.red
            }
            
        }
         
        
         
        
        
    }
    func didFailWithError(error: Error) {
        DispatchQueue.main.async{print("error found", error)
        }
    }
}
