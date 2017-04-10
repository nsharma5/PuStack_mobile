//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport

var str = "Hello, playground"
let color = UIColor (red: 1 , green: 1 , blue: 0 , alpha: 0 )
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.red
view.frame = CGRect (x: 0 ,y: 0 ,width: 200 ,height: 200 )
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
let label = UILabel (frame: CGRect (x: 5 , y: 5 , width: 200 , height: 20 ))
label.text = str
view.addSubview(label)

