//
//  SectionView.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
                .padding(.horizontal)
            
            content()
        }
        .padding(.vertical)
    }
}
