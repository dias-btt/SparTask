//
//  ProductGridCell.swift
//  SparTask
//
//  Created by Диас Сайынов on 16.08.2024.
//

import SwiftUI
import SwiftData

struct ProductGridCell: View {
    
    let product: Product
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SavedProduct.timestamp, order: .reverse) var products: [SavedProduct]
    @State private var isSaved: Bool = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ZStack{
                    Image(product.image)
                    
                    VStack{
                        HStack{
                            ZStack(alignment: .top){
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
                            Spacer()
                                VStack{
                                    Image("check")
                                        .padding(.horizontal)
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
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        HStack{
                            HStack{
                                Image("star")
                                Text(String(format: "%.1f", product.rating))
                                    .font(.caption)
                            }
                            if let discount = product.discount{
                                Text("\(discount)%")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("Red1"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                    .padding(5)
                }
                .frame(width: 168, height: 148)

                Text(product.name)
                    .font(.system(size: 12))
                    .padding(5)
                
                HStack{
                    VStack(alignment: .leading){
                        HStack(spacing: 3){
                            Text("\(product.price)")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            Text("90")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                            Image("perAmount")
                        }
                        Text("\(product.oldPrice)")
                            .foregroundStyle(Color.gray)
                            .strikethrough()
                    }
                    
                    Spacer(minLength: -20)
                    
                    ZStack{
                        Rectangle()
                            .foregroundStyle(Color("Primary"))
                            .clipShape(Capsule())
                            .frame(width: 48, height: 36)
                        Image("basket")
                    }
                }
                .padding(5)
            }
            .padding(5)
        }
        //.shadow(color: .black.opacity(0.2), radius: 4)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(width: 168)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
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
    ProductGridCell(product: Product(name: "Огурцы тепличные cадово-огородные", image: "image", rating: 4.1, ratingCount: 20, price: 295, oldPrice: 189, specialOffer: .hitOnPrice, discount: 25, country: "France"))
}
