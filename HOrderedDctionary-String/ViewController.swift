//
//  ViewController.swift
//  HOrderedDctionary-String
//
//  Created by JuanFelix on 2017/4/14.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dicA:Dictionary<String,Any> = ["A":Int(1),"E":"5","D":Double(4.25),"B":"2","C":"3"]
        let sortedA = dicA.sorted { $0.0 < $1.0}
        print("System Sorted:")
        print(sortedA.description )
        print("Dicitonary Ordered String:")
        print(dicA.zx_TestAlv1())//测试处理一层
        print(dicA.zx_TestBlv1())//测试处理一层
        print(dicA.zx_sortJsonString())//支持嵌套
        
        
        let array:Array<Any> = ["B",Double(3.1),"3","C",Int(2),"A",Int(1),dicA]
        print("Array Ordered String:")
        print(array.zx_sortJsonString())
        print("Mix Dicitonary Ordered String:")
        let userInfo:Dictionary<String,Any> = ["B":["222","vccc","333","111","ggg"],
                                                "D":"4",
                                                "C":["A":"1","E":"5","D":"4","B":"2","C":"3"],
                                                "A":"1",
                                                "E":"5",
                                                "G":["BString",
                                                     "3",
                                                     "CString",
                                                     Int(2),
                                                     "AString",
                                                     Int(1),
                                                     ["name":"JuanFelix",
                                                      "tel":"18081000000",
                                                      "sex":Int(1),
                                                      "image":"/upload/image/1.png"],
                                                     ["name":"Tom",
                                                      "sex":Int(1),
                                                      "image":"/upload/image/3.png",                                              "tel":"18081000001"],
                                                     ["tel":"18081000002",
                                                      "image":"/upload/image/2.png",
                                                      "name":"Lily",
                                                      "sex":Int(0)],
                                                     ["tel":"18081000003",
                                                      "sex":Int(0),
                                                      "image":"/upload/image/7.png",
                                                      "name":"Judy"],
                                                     ["image":"/upload/image/4.png",
                                                      "sex":Int(0),
                                                      "name":"Mary",
                                                      "tel":"18081000004"],
                                                     ["sex":Int(0),
                                                      "tel":"18081000005",
                                                      "name":"Phenix",
                                                      "image":"/upload/image/5.png"]
                                                     ],
                                                "F":"6"]
        print(userInfo.zx_sortJsonString())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Dictionary {//测试
    func zx_TestAlv1() -> String {//先获取key值排序，再取值拼接为JsonString
        var tempDic = self as! Dictionary<String,Any>
        var keys = Array<String>()
        for key in tempDic.keys {
            keys.append(key)
        }
        keys.sort { $0 < $1 }
        var arr: Array<String> = []
        for key in keys{
            arr.append("\"\(key)\":\"\(tempDic[key]!)\"")
        }
        
        var signString = "{"
        signString += arr.joined(separator: ",")
        signString += "}"
        return signString
    }
    
    func zx_TestBlv1() -> String {//先调用系统的排序方法获取String，再通过正则处理
        let tempDic = self as! Dictionary<String,Any>
        //系统排序后得到奇葩的 (key: Key, value: Value) 数组，没法玩啊
        //所以直接获取Description String
        var string = tempDic.sorted { $0.0 < $1.0 }.description//系统排序后的字符串
        let regexString = "\\(key:[ \t]?\"?([^()\"]*)\"?[ \t]?,[ \t]?value:[ \t]*\"?([^()\"]*)\"?\\)"
        let regex = try? NSRegularExpression.init(pattern: regexString, options: .caseInsensitive)
        let matches = regex?.matches(in: string, options: [], range: NSMakeRange(0, string.characters.count))
        if let matches = matches {
            var arr: Array<String> = []
            for  match in matches {
                let g1 = match.rangeAt(1)
                let g2 = match.rangeAt(2)
                var startIndex  = string.index(string.startIndex, offsetBy: g1.location)
                var endIndex    = string.index(string.startIndex, offsetBy: (g1.location + g1.length))
                let key = "\"\(string.substring(with: startIndex..<endIndex))\""
                
                startIndex  = string.index(string.startIndex, offsetBy: g2.location)
                endIndex    = string.index(string.startIndex, offsetBy: (g2.location + g2.length))
                let value = "\"\(string.substring(with: startIndex..<endIndex))\""
                arr.append("\(key):\(value)")
            }
            var signString = "{"
            signString += arr.joined(separator: ",")
            signString += "}"
            return signString
        }
        return ""
    }
}

