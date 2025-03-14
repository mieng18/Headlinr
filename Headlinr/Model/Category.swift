//
//  Category.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/14/25.
//


import SwiftUI

enum Category: String, CaseIterable {
    case allTitles = "All"
    case entertainment = "Entertainment"
    case business = "Business"
    case food = "Food"
    case health = "Health"
    case tech = "Technology"
    case science = "Science"
    case intelligence = "Intelligence"
    case crypto = "Crypto"
    case hobbies = "Hobbies"
    case lifestyle = "Lifestyle"
    case kids = "kids"
    case sports = "Sports"
    case beauty = "Beauty"
    case travel = "Travel"
    case cars = "Cars"
    case outdoors = "Outdoors"

    var icon: String {
        switch self {
        case .allTitles: return "square.grid.2x2.fill"
        case .entertainment: return "tv.fill"
        case .business: return "briefcase.fill"
        case .food: return "fork.knife"
        case .health: return "stethoscope"
        case .tech: return "cpu.fill"
        case .science: return "cpu.fill"
        case .intelligence: return "brain.head.profile"
        case .crypto: return "bitcoinsign.circle"
        case .hobbies: return "paintpalette.fill"
        case .lifestyle: return "person.fill"
        case .kids: return "stroller.fill"
        case .sports: return "figure.walk"
        case .beauty: return "heart"
        case .travel: return "airplane"
        case .cars: return "car.fill"
        case .outdoors: return "tree.fill"
       
        }
    }
}


