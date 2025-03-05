import SwiftUI

struct MovieMetadataView: View {
    let status: String?
    let runtime: Int?
    let budget: Int?
    let revenue: Int?
    
    var body: some View {
        let gridItems = [GridItem(.adaptive(minimum: 150))]
        
        return LazyVGrid(columns: gridItems, spacing: 16) {
            InfoCell(title: "Status", value: status ?? "N/A")
            InfoCell(title: "Runtime", value: runtimeFormatted)
            InfoCell(title: "Budget", value: budgetFormatted)
            InfoCell(title: "Revenue", value: revenueFormatted)
        }
        .padding()
    }
    
    private var runtimeFormatted: String {
        guard let minutes = runtime else { return "N/A" }
        return "\(minutes / 60)h \(minutes % 60)m"
    }
    
    private var budgetFormatted: String {
        guard let budget = budget, budget > 0 else { return "N/A" }
        return NumberFormatter.localizedString(from: NSNumber(value: budget), number: .currency)
    }
    
    private var revenueFormatted: String {
        guard let revenue = revenue, revenue > 0 else { return "N/A" }
        return NumberFormatter.localizedString(from: NSNumber(value: revenue), number: .currency)
    }
} 