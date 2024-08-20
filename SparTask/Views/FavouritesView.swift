//
//  FavouritesView.swift
//  SparTask
//
//  Created by Диас Сайынов on 19.08.2024.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    @Query(sort: \SavedProduct.timestamp, order: .reverse) var products: [SavedProduct]
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(products){ product in
                    let product = Product(name: product.name, image: product.image, rating: product.rating, ratingCount: product.ratingCount, price: product.price, oldPrice: product.oldPrice, specialOffer: nil, discount: product.discount, country: product.country)
                    
                    ProductListCell(product: product)
                }
            }
        }
    }
}

#Preview {
    FavouritesView()
}
