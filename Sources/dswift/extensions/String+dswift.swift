//
//  String+dswift.swift
//  dswift
//
//  Created by Tyler Anger on 2018-12-04.
//

import Foundation
import SwiftPatches

extension String: Error { }

internal extension String {
    
    /// Provides a complate range of the given string
    var completeRange: Range<String.Index> {
        return Range<String.Index>(uncheckedBounds: (lower: self.startIndex, upper: self.endIndex))
    }
    
    /// Provides a complete NSRange of the given string
    var completeNSRange: NSRange {
        return NSRange(self.completeRange, in: self)
    }
    
    /// Repeats the given string n times
    func repeated(_ times: Int) -> String {
        return String(repeating: self, count: times)
    }
    
    
    /// Finds the last index of a given string
    func lastIndex(of: String) -> String.Index? {
        guard let r = self.range(of: of, options: .backwards) else { return nil }
        return r.lowerBound
    }
    
    /// Generates a random string of a given length (default 20 characters)
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            #if os(Linux)
            let randomValue = Foundation.random() % base.count
            #else
            let randomValue = Int(arc4random_uniform(UInt32(base.count)))
            #endif
            //let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    /// Counts a the number of times a string occurs
    func countOccurrences<Target>(of string: Target, inRange searchRange: Range<String.Index>? = nil) -> Int where Target : StringProtocol {
        var rtn: Int = 0
        var workingRange: Range<String.Index>? = searchRange ?? Range<String.Index>(uncheckedBounds: (lower: self.startIndex,
                                                                                                      upper: self.endIndex))
        while workingRange != nil {
            guard let r = self.range(of: string, range: workingRange) else {
                break
            }
            rtn += 1
            if r.upperBound == workingRange!.upperBound { workingRange = nil }
            else {
                workingRange = Range<String.Index>(uncheckedBounds: (lower: r.upperBound,
                                                                     upper: workingRange!.upperBound))
            }
        }
        
        return rtn
    }
    
    /// Trims any spaces from the right side of the given string
    func rtrim() -> String {
        var rtn: String = self
        while rtn.hasSuffix(" ") { rtn.removeLast() }
        return rtn
    }
    
    /// Trims any spaces from the left side of the given string
    func ltrim() -> String {
        var rtn: String = self
        while rtn.hasPrefix(" ") { rtn.removeFirst() }
        return rtn
    }
    
    /// Trims any spaces from both sides of the given string
    func trim() -> String {
        var rtn: String = self
        while rtn.hasPrefix(" ") { rtn.removeFirst() }
        while rtn.hasSuffix(" ") { rtn.removeLast() }
        return rtn
    }
    
    
    
}

// Path Properties
internal extension String {
    /// Gets the path components of the given string
    var pathComponents: [String] {
        guard self != "/" else { return [self] }
        var comps = self.components(separatedBy: "/")
        if self.hasPrefix("/") && comps[0] == "" {
            comps[0] = "/"
        }
        if self.hasSuffix("/") && comps[comps.count - 1] == "" {
            comps[comps.count - 1] = "/"
        }
        
        return comps
        
    }
    /// Gets the last path component of the given string
    var lastPathComponent: String {
        let comps = self.pathComponents
        var rtn = comps[comps.count - 1]
        if rtn == "/" && comps.count > 1 { rtn =  comps[comps.count - 2]}
        return rtn
    }
    
    /// Deletes the last path component of the given string
    var deletingLastPathComponent: String {
        var comps = self.pathComponents
        comps.removeLast()
        var startValue = comps.removeFirst()
        if comps.count > 0 && startValue == "/" { startValue = "" }
        let rtn: String = comps.reduce(startValue) { return $0 + "/" + $1 }
        return rtn
    }
    
    /// Gets the path extension of the given string
    var pathExtension: String {
        var comps = self.pathComponents
        if comps.count > 1 && comps[comps.count - 1] == "/" {
            comps.removeLast()
        }
        let file = comps[comps.count - 1]
        guard let idx = file.lastIndex(of: ".") else { return "" }
        return String(file.suffix(from: file.index(after: idx)))
    }
    
    /// Deletes the path extension of the given string
    var deletingPathExtension: String {
        var comps = self.pathComponents
        if comps.count > 1 && comps[comps.count - 1] == "/" {
            comps.removeLast()
        }
        if let idx = comps[comps.count - 1].lastIndex(of: ".") {
            comps[comps.count - 1] = String(comps[comps.count - 1].prefix(upTo: idx))
        }
        var startValue = comps.removeFirst()
        if comps.count > 0 && startValue == "/" { startValue = "" }
        let rtn: String = comps.reduce(startValue) { return $0 + "/" + $1 }
        
        return rtn
    }
    /// Returns a full path of the current relative string combined with the provided base string
    func fullPath(from base: String = FileManager.default.currentDirectoryPath) -> String {
        guard !self.hasPrefix("/") else { return self }
        guard !self.hasPrefix("~/") else {
            return NSString(string: NSString(string: self).expandingTildeInPath).standardizingPath
        }
        
        var rtn: String = base
        if !rtn.hasSuffix("/") { rtn += "/" }
        rtn += self
        return NSString(string: rtn).standardizingPath
    }
}
