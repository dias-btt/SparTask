//
//  ContentView.swift
//  SparTask
//
//  Created by Диас Сайынов on 07.08.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var gridSelected: Bool = true

    var body: some View {
        VStack(alignment: .leading){
            Button {
                gridSelected.toggle()
            } label: {
                ZStack{
                    Rectangle()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(Color("Gray"))
                        .frame(width: 40, height: 40)
                    Image(gridSelected ? "grid" : "list")
                }
            }
            .padding(.horizontal)
            if gridSelected {
                VStack{
                    Rectangle()
                        .foregroundStyle(Color("Gray"))
                        .frame(height: 1)
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(mockProducts) { product in
                                ProductGridCell(product: product)
                            }
                        }
                    }
                }
            } else {
                ScrollView{
                    VStack{
                        ForEach(mockProducts){ product in
                            ProductListCell(product: product)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SavedProduct.self, inMemory: true)
}
