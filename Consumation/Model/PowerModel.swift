//
//  PowerModel.swift
//  Consumation
//
//  Created by manfred kohl on 16/04/2024.
//

import Foundation
class PowerModel {
    var solar:String = ""
    var enel:String = ""
    var totalConsumption:String = ""
    var ecoMode:Bool=false
     func computeTotalConsumption()
     
{
        var dummyEnel:Float
        var dummySolar:Float
        if (enel != "") && (solar != "") {
            dummySolar = ( solar as NSString).floatValue
            dummyEnel = ( enel as NSString).floatValue
            if dummyEnel <= 0.0 {
                self.totalConsumption = String( format:"%.2f",  -dummySolar+dummyEnel  )
                ecoMode=true   }
        else {  dummySolar = ( solar as NSString).floatValue
            self.totalConsumption =  String(format: "%.2f", -dummySolar+dummyEnel )
            ecoMode = false
    
        }
 

  
}
}
    
}
