//: Playground - noun: a place where people can play
import UIKit
import PlaygroundSupport

let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.red
container.addSubview(view)

PlaygroundPage.current.liveView = container
PlaygroundPage.current.needsIndefiniteExecution = true
