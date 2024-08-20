//
//  ProductListCell.swift
//  SparTask
//
//  Created by Диас Сайынов on 07.08.2024.
//

import SwiftUI
import SwiftData

struct ProductListCell: View {
    
    let product: Product
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SavedProduct.timestamp, order: .reverse) var products: [SavedProduct]
    @State private var isSaved: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundStyle(Color.gray)
                .frame(height: 1)
                .padding(.vertical)
            HStack{
                // Product Image
                ZStack{
                    Image(product.image)
                        
                    VStack{
                        ZStack{
                            if let offer = product.specialOffer{
                                Rectangle()
                                    .foregroundStyle(offer.color)
                                    .clipShape(
                                        RoundedCornerShape(
                                            corners: [.topLeft, .topRight, .bottomRight],
                                            radius: 6
                                        )
                                    )
                                    .frame(width: 84, height: 16)
                                Text(offer.rawValue)
                                    .font(.system(size: 10))
                                    .foregroundStyle(Color.white)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        if let discount = product.discount{
                            Text("\(discount)%")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(Color("Red1"))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .frame(width: 144, height: 144)
                
                // Product Info
                VStack{
                    // Rating
                    HStack{
                        Image("star")
                        
                        Text(String(format: "%.1f", product.rating))
                            .font(.caption)
                        Rectangle()
                            .frame(width: 1, height: 15)
                            .foregroundStyle(Color.gray)
                        Text("\(product.ratingCount) отзывов")
                            .font(.caption)
                        Spacer()
                        Image("check")
                            .padding(.horizontal)
                    }
                    
                    // Name
                    HStack{
                        Text(product.name)
                            .font(.caption)
                        Spacer()
                        Button(action: {
                            let selectedProduct = products.first { $0.id == product.id }
                            if (selectedProduct?.isSaved ?? false) {
                                deleteProduct()
                            } else {
                                saveProduct()
                            }
                            isSaved.toggle()
                        }, label: {
                            Image(isSaved ? "saved" : "save")
                        })
                        .padding(.horizontal)
                    }
                    
                    // Country
                    if let country = product.country{
                        HStack{
                            Text(country)
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                            Image("FranceFlag")
                            Spacer()
                        }
                    }
                    
                    // Price
                    HStack{
                        VStack(alignment: .leading){
                            HStack(spacing: 3){
                                Text("\(product.price)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("90")
                                    .fontWeight(.bold)
                                Image("perAmount")
                            }
                            Text("\(product.oldPrice)")
                                .foregroundStyle(Color.gray)
                                .strikethrough()
                        }
                        Spacer()
                        
                        ZStack{
                            Rectangle()
                                .foregroundStyle(Color("Primary"))
                                .clipShape(Capsule())
                                .frame(width: 48, height: 36)
                            Image("basket")
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func saveProduct() {
        let savedProduct = SavedProduct(
            id: product.id,
            isSaved: true,
            name: product.name,
            image: product.image,
            rating: product.rating,
            ratingCount: product.ratingCount,
            price: product.price,
            oldPrice: product.oldPrice,
            discount: product.discount,
            country: product.country,
            timestamp: Date()
        )
        
        modelContext.insert(savedProduct)   
    }
    
    private func deleteProduct() {
        if let savedProduct = fetchSavedProduct() {
            modelContext.delete(savedProduct)
            savedProduct.isSaved = false
        }
    }
        
    private func fetchSavedProduct() -> SavedProduct? {
        products.first { $0.id == product.id }
    }
        
    private func checkIfSaved() {
        isSaved = fetchSavedProduct() != nil
    }
}

#Preview {
    ProductListCell(product: Product(name: "Огурцы тепличные cадово-огородные", image: "image", rating: 4.1, ratingCount: 20, price: 295, oldPrice: 189, specialOffer: .hitOnPrice, discount: 25, country: "France"))
}
