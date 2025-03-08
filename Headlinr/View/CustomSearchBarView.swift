//
//  CustomSearchBarView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/6/25.
//

import SwiftUI 
struct CustomSearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            TextField("Search...", text: $searchText)
                .padding([.trailing,.top,.bottom
                         ])
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .padding(.horizontal, 10)
        .frame(height: 40)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding([.leading, .trailing],16)
        .padding([.top,.bottom],12)
    
    }
}
