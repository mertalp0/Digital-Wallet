//
//  AmountCardType.swift
//  DigitalWallet
//
//  Created by mert alp on 25.07.2024.
//

import Foundation
enum AmountCardType: Identifiable, Equatable {
    case fifty
    case oneHundred
    case fiveHundred
    case oneThousand
    case twoThousand
    case other

    var id: String {
        switch self {
        case .fifty:
            return "50"
        case .oneHundred:
            return "100"
        case .fiveHundred:
            return "500"
        case .oneThousand:
            return "1000"
        case .twoThousand:
            return "2000"
        case .other:
            return "other"
        }
    }

    var displayText: String {
        switch self {
        case .fifty:
            return "$50"
        case .oneHundred:
            return "$100"
        case .fiveHundred:
            return "$500"
        case .oneThousand:
            return "$1000"
        case .twoThousand:
            return "$2000"
        case .other:
            return "Other"
        }
    }
}
