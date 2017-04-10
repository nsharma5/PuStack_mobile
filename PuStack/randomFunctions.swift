//
//  randomFunctions.swift
//  PuStack
//
//  Created by Neha Sharma on 4/10/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import Foundation
import Glibc

class Random {
    static let initialize:Void = {
        srandom(UInt32(time(nil)))
        return ()
    }()
}

func randomString(ofLength length:Int) -> String {
    Random.initialize
    let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let charactersArray:[Character] = Array(charactersString.characters)
    
    var string = ""
    for _ in 0..<length {
        string.append(charactersArray[Int(random()) % charactersArray.count])
    }
    
    return string
}

func randomInt() -> Int {
    Random.initialize
    return Int(random() % 10000)
}
