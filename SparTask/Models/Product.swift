//
//  Product.swift
//  SparTask
//
//  Created by Диас Сайынов on 16.08.2024.
//

import SwiftData
import SwiftUI

enum SpecialOffer: String, Codable {
    case hitOnPrice = "Удар по ценам"
    case new = "Новинки"
    case cardPrice = "Цена по карте"

    var color: Color {
        switch self {
        case .hitOnPrice:
            return Color("Red2")
        case .new:
            return Color("Purple")
        case .cardPrice:
            return Color("Primary")
        }
    }
}

struct Product: Identifiable {
    var id = UUID()
    let name: String
    let image: String
    let rating: Double
    let ratingCount: Int
    let price: Int
    let oldPrice: Int
    let specialOffer: SpecialOffer?
    let discount: Int?
    let country: String?
}

let mockProducts: [Product] = [
    Product(name: "Огурцы тепличные cадово-огородные", image: "image", rating: 4.1, ratingCount: 20, price: 295, oldPrice: 189, specialOffer: .hitOnPrice, discount: 25, country: "France"),
    Product(name: "Свежие помидоры", image: "image", rating: 3.8, ratingCount: 50, price: 250, oldPrice: 299, specialOffer: .new, discount: 20, country: nil),
    Product(name: "Фермерские яблоки", image: "image", rating: 4.5, ratingCount: 120, price: 180, oldPrice: 210, specialOffer: .cardPrice, discount: 15, country: "USA"),
    Product(name: "Бананы высшего сорта", image: "image", rating: 4.7, ratingCount: 200, price: 150, oldPrice: 190, specialOffer: nil, discount: nil, country: nil),
    Product(name: "Органическая морковь", image: "image", rating: 4.2, ratingCount: 90, price: 100, oldPrice: 120, specialOffer: nil, discount: 20, country: "Netherlands"),
    Product(name: "Свежая клубника", image: "image", rating: 4.9, ratingCount: 300, price: 350, oldPrice: 399, specialOffer: .cardPrice, discount: 12, country: nil),
    Product(name: "Черешня сладкая", image: "image", rating: 4.3, ratingCount: 85, price: 400, oldPrice: 450, specialOffer: .hitOnPrice, discount: 11, country: "Turkey"),
    Product(name: "Персики солнечные", image: "image", rating: 4.4, ratingCount: 75, price: 280, oldPrice: 320, specialOffer: .new, discount: 10, country: "Greece"),
    Product(name: "Гранат", image: "image", rating: 4.6, ratingCount: 150, price: 220, oldPrice: 250, specialOffer: nil, discount: 12, country: nil)
]

@Model
final public class SavedProduct {
    public var id: UUID
    var isSaved: Bool
    let name: String
    let image: String
    let rating: Double
    let ratingCount: Int
    let price: Int
    let oldPrice: Int
    let discount: Int?
    let country: String?
    var timestamp: Date
    
    init(id: UUID = UUID(), isSaved: Bool, name: String, image: String, rating: Double, ratingCount: Int, price: Int, oldPrice: Int, discount: Int? = nil, country: String? = nil, timestamp: Date) {
        self.id = id
        self.isSaved = isSaved
        self.name = name
        self.image = image
        self.rating = rating
        self.ratingCount = ratingCount
        self.price = price
        self.oldPrice = oldPrice
        self.discount = discount
        self.country = country
        self.timestamp = timestamp
    }
}
