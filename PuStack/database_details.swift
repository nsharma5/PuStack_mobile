//
//  database_details.swift
//  PuStack
//
//  Created by Neha Sharma on 4/10/17.
//  Copyright © 2017 Aakanksha . All rights reserved.
//

import Foundation
import Glibc
import MySQL

var mysql:Database
do {
    mysql = try Database(host:"localhost",
                         user:"swift",
                         password:"swiftMobile",
                         database:"swift_test")
    try mysql.execute("SELECT @@version")
} catch {
    print("Unable to connect to MySQL:  \(error)")
    exit(-1)
}
do {
    try mysql.execute("DROP TABLE IF EXISTS test")
    try mysql.execute("CREATE TABLE test (test1 INT(4), test2 VARCHAR(16))")
    
    for i in 1...10 {
        let int    = randomInt()
        let string = randomString(ofLength:16)
        try mysql.execute("INSERT INTO test VALUES (\(int), '\(string)')")
    }
    
    // Query
    let results = try mysql.execute("SELECT * FROM test")
    for result in results {
        if let test1 = result["test1"]?.int,
            let test2 = result["test2"]?.string {
            print("\(test1)\t\(test2)")
        }
    }
} catch {
    print("Error:  \(error)")
    exit(-1)
}
