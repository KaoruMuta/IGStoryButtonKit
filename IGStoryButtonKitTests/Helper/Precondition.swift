//
//  Precondition.swift
//  IGStoryButtonKitTests
//
//  Created by k_muta on 2021/01/12.
//

import Foundation

func precondition(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
    preconditionClosure(condition(), message(), file, line)
}

var preconditionClosure: (Bool, String, StaticString, UInt) -> () = defaultPreconditionClosure
let defaultPreconditionClosure = { Swift.precondition($0, $1, file: $2, line: $3) }
