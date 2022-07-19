//
//  Value.swift
//  ministock
//
//  Created by 윤지용 on 2022/07/15.
//

import Foundation
import SwiftUI

class Value {
    
    public var global: String = "test"
    
    struct StaticIstance {
        static var instance: Value?
    }
    
    class func sharedInstance() -> Value {
        if(StaticIstance.instance == nil){
            StaticIstance.instance = Value()
        }
        return StaticIstance.instance!
    }
}
