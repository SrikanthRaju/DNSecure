//
//  Extensions.swift
//  DNSecure
//
//  Created by Kenta Kubo on 10/27/20.
//

import NetworkExtension

extension NEOnDemandRuleInterfaceType: CaseIterable {
    public static var allCases: [Self] {
        #if os(macOS)
            return [.any, .ethernet, .wiFi]
        #else
            return [.any, .wiFi, .cellular]
        #endif
    }
}

extension NEOnDemandRuleInterfaceType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .any:
            return "Any"
        #if os(macOS)
        case .ethernet:
            return "Ethernet"
        #endif
        case .wiFi:
            return "Wi-Fi"
        #if os(iOS)
        case .cellular:
            return "Cellular"
        #endif
        default:
            return "Unknown"
        }
    }
}

extension NEOnDemandRuleInterfaceType: Codable {}

extension NEOnDemandRuleAction: CaseIterable {
    public static var allCases: [Self] {
        [.connect, .disconnect, .evaluateConnection, .ignore]
    }
}

extension NEOnDemandRuleAction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .connect:
            return "Apply settings"
        case .disconnect:
            return "Do not apply settings"
        case .evaluateConnection:
            return "Apply with excluded domains"
        case .ignore:
            return "As is"
        default:
            return "Unknown"
        }
    }
}

extension NEOnDemandRuleAction: Codable {}
