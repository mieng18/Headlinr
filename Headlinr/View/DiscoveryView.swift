//
//  DiscoveryView.swift
//  Headlinr
//
//  Created by Maisie Ng on 3/11/25.
//


import SwiftUI

struct DiscoveryView: View {
    
    var adaptiveColumns: [GridItem] {
        let screenWidth = UIScreen.main.bounds.width
        let totalSpacing: CGFloat = 10 // Space between items
        let totalPadding: CGFloat = 32 // Left & Right padding
        let columnWidth = (screenWidth - totalPadding - totalSpacing) / 2
        
        return [GridItem(.fixed(columnWidth)), GridItem(.fixed(columnWidth))]
    }


    var body: some View {
        NavigationStack {
            
            VStack{
                LazyVGrid(columns: adaptiveColumns, spacing: 12)  {
                
                    ForEach(Category.allCases, id: \.self) { category in
                        NavigationLink(destination: Text("Articles for \(category.rawValue)")) {
                            HStack {
                                Image(systemName: category.icon)
                                    .foregroundColor(.gray)
                                    .frame(width: 24)
                                Text(category.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                
                                Spacer()
                            
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.gray)
                                    .frame(width: 12,height: 12)
                                
                            }
                            .padding([.leading,.trailing],12)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    .padding([.leading,.trailing],5)
                }
            }

        }
        .padding()
    }
}

#Preview {
    DiscoveryView()
}
