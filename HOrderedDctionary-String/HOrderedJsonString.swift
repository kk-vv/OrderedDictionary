//
//  Dictionary+OrderedString.swift
//  HOrderedDctionary-String
//
//  Created by JuanFelix on 2017/4/14.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

extension Dictionary {
    func zx_sortJsonString() -> String {
        var tempDic = self as! Dictionary<String,Any>
        var keys = Array<String>()
        for key in tempDic.keys {
            keys.append(key)
        }
        keys.sort { $0 < $1 }
        var signString = "{"
        var arr: Array<String> = []
        for key in keys {
            let value = tempDic[key]
            if let value = value as? Dictionary<String,Any> {
                arr.append("\"\(key)\":\(value.zx_sortJsonString())")
            } else if let value = value as? Array<Any> {
                arr.append("\"\(key)\":\(value.zx_sortJsonString())")
            } else {
                arr.append("\"\(key)\":\"\(tempDic[key]!)\"")
            }
        }
        signString += arr.joined(separator: ",")
        signString += "}"
        return signString
    }
}

extension Array {
    func  zx_sortJsonString() -> String {
        let array = self
        var arr: Array<String> = []
        var signString = "["
        for value in array {
            if let value = value as? Dictionary<String,Any> {
                arr.append(value.zx_sortJsonString())
            } else if let value = value as? Array<Any> {
                arr.append(value.zx_sortJsonString())
            } else {
                arr.append("\"\(value)\"")
            }
        }
        arr.sort { $0 < $1 }
        signString += arr.joined(separator: ",")
        signString += "]"
        return signString
    }
}
