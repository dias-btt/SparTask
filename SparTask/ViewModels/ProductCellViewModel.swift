//
//  ProductCellViewModel.swift
//  SparTask
//
//  Created by Диас Сайынов on 20.08.2024.
//

import SwiftUI
import SwiftData

final class ProductCellViewModel: ObservableObject {
    let product: Product
    @Environment(\.modelContext) private var modelContext

    @Published var isSaved: Bool = false
    
    @Query(sort: \SavedProduct.timestamp, order: .reverse) private var products: [SavedProduct]

    init(product: Product) {
        self.product = product
        checkIfSaved()
    }

    func toggleSave() {
        let selectedProduct = fetchSavedProduct()
        if selectedProduct?.isSaved ?? false {
            deleteProduct()
        } else {
            saveProduct()
        }
        isSaved.toggle()
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
        }
    }
    
    private func fetchSavedProduct() -> SavedProduct? {
        products.first { $0.id == product.id }
    }
    
    private func checkIfSaved() {
        isSaved = fetchSavedProduct() != nil
    }
}
