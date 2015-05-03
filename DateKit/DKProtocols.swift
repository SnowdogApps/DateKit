//
//  DateKitProtocols.swift
//  DateKit
//
//  Created by Radoslaw Szeja on 18.01.2015.
//  Copyright (c) 2015 Radosław Szeja. All rights reserved.
//

import Foundation

// MARK: Protocols
internal protocol DateKitLiteralGetters {
    var second  : Int { get }
    var minute  : Int { get }
    var hour    : Int { get }
    var day     : Int { get }
    var month   : Int { get }
    var year    : Int { get }
    var era     : Int { get }
}

internal protocol DateKitOperationGetters {
    var seconds     : Operation { get }
    var minutes     : Operation { get }
    var hours       : Operation { get }
    var days        : Operation { get }
    var months      : Operation { get }
    var years       : Operation { get }
    var eras        : Operation { get }
}

internal protocol DateKitOperationSetters {
    func second(value: Int)     -> Operation
    func minute(value: Int)     -> Operation
    func hour(value: Int)       -> Operation
    func day(value: Int)        -> Operation
    func month(value: Int)      -> Operation
    func year(value: Int)       -> Operation
    func era(value: DateKit.Era)    -> Operation
}
