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

// create a table for our tests
try con.exec("CREATE TABLE test (id STRING NOT NULL AUTO_INCREMENT, PRIMARY KEY (id))")

// prepare a new statement for insert
let ins_stmt = try con.prepare("INSERT INTO test, VALUES(?,?,?)")

// prepare a new statement for select
let select_stmt = try con.prepare("SELECT * FROM test WHERE Id=?")

// insert 50 rows
for i in 1...50 {
    // use a int, float and a string
    try ins_stmt.exec([10+i, Float(i)/5.0, "name for \(i)"])
}

// read rows 10 to 30
for i in 10...30 {
    do {
        // send query
        let res = try select_stmt.query([i])
        
        //read all rows from the resultset
        let rows = try res.readAllRows()
        
        // print the rows
        print(rows)
    }
    catch (let err) {
        // if we get a error print it out
        print(err)
    }
}
try con.close()
};
catch (let e) {
    print(e)
};


// create a new Table object with name on a connection
let table = MySQL.Table(tableName: "createtable_obj", connection: con)
// drop the table if it exists
try table.drop()

// create a new object
let object = obj()

// create the MySQL Table based on the Swift object
try table.create(object)

// create a table with given primaryKey and auto_increment set to true
try table.create(object, primaryKey: "id", autoInc: true)

//inserting Swift object using MySQL row
try table.insert(object)

//updating Object using MySQL row
obj["iint32"] = 4000
obj["iint16"] = Int16(-100)

try table.update(obj, key: "id")

// select all rows from the table given a condition
if let rows = try table.select(Where: ["id=",90, "or id=",91, "or id>",95]) {
    print(rows)
}

// select rows specifying the columns we want and a select condition
if let rows = try table.select(["str", "uint8_array"], Where: ["id=",90, "or id=",91, "or id>",95]) {
    print(rows)
}
