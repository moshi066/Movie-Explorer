import SwiftUI

struct MovieHeaderView: View {
    let posterPath: String?
    let tagline: String?
    let overview: String?
    @State private var isOverviewExpanded = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "\(Constants.imageBaseURL)\(posterPath ?? "")")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                case .failure(_):
                    Image(systemName: "film")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .foregroundColor(.gray)
                case .empty:
                    ProgressView()
                        .frame(height: 300)
                @unknown default:
                    Color.gray.frame(height: 300)
                }
            }
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.9)]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 8) {
                if let tagline = tagline, !tagline.isEmpty {
                    Text(tagline)
                        .font(.headline)
                        .italic()
                }
                
                Text(overview ?? "")
                    .font(.body)
                    .lineLimit(isOverviewExpanded ? nil : 3)
                    .multilineTextAlignment(.leading)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isOverviewExpanded.toggle()
                        }
                    }
                
                if overview != nil {
                    HStack {
                        Spacer()
                        Text(isOverviewExpanded ? "Show Less" : "Read More")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isOverviewExpanded.toggle()
                                }
                            }
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
        }
    }
} 
