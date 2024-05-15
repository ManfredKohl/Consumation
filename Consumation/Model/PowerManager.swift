//
//  PowerManager.swift
//  Consumation
//power manager manages access to the powermeters and delivers power values to app
//reference:
//http://10.0.0.81/emeter/0/em_data
//example output
//
//{"power":101.76,"reactive":-326.23,"pf":-0.30,"voltage":233.53,"is_valid":true,"total":1521371.8,"total_returned":663971.6}
//  Created by manfred kohl on 16/04/2024.
//
import Foundation
protocol PowerManagerDelegate{
    func didUpdatePower(_ powerManager:PowerManager, power:PowerModel)
    func didFailWithError(error:Error)
}

struct PowerManager {
    let solarPowerMeterURL="http://10.0.0.80/emeter/0/em_data"
    let enelPowerMeterURL="http://10.0.0.81/emeter/0/emdata"
    var power = PowerModel()
    var delegate: PowerManagerDelegate?
    // should update every 5 seconds
     
    
     func fetchPower(select:Int){
        
        var urlString:String
         
        if (select == 0) {  urlString = solarPowerMeterURL}
        else {  urlString = enelPowerMeterURL}
        performRequest(urlString:urlString, count:select)
         
    }
      func performRequest(urlString:String, count:Int )
    {
        var powerString:String = "empty"
        if let url = URL(string:urlString){
            //let session = URLSession(configuration: .default)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate!.didFailWithError(error:error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data:safeData,encoding:.utf8)
                    //print(dataString)
                    powerString = extractPower(from:dataString!)
                //    print("extracting",powerString)
                     
                    if (count == 0) { power.solar = powerString}
                    if (count == 1)  { power.enel = powerString}
                    
                    power.computeTotalConsumption()
                    self.delegate?.didUpdatePower(self,  power: power)
                     
                     
                    
                     
            }
            }
            task.resume()
        }
         
        
         
    }
    func extractPower(from:String)->String
    { //very raw  
        var idx1:String.Index
        var idx2:String.Index
                let needle: Character = ":"
                idx1 = from.firstIndex(of: needle)!
        
                let comma: Character = ","
                idx2 = from.firstIndex(of: comma)!
                          
                let range =  idx1..<idx2
                var powerString = String(from[ range])
        
                powerString = String(powerString.dropFirst()) //get rid if leading ":"
        // print(powerString)
        return(powerString);
        
    }
    }

 
