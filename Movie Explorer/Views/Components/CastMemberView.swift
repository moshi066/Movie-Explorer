//
//  CastMemberView.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//
import SwiftUI

struct CastMemberView: View {
    let member: CastMember
    var imageSize: CGFloat = 50 
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            // Profile Image
            Group {
                if let path = member.profilePath {
                    AsyncImage(url: URL(string: "\(Constants.imageBaseURL)\(path)")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 3)
            
            // Name and Character
            VStack(alignment: .center, spacing: 4) {
                Text(member.name)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(member.character)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: imageSize + 20)
        }
        .padding(.horizontal, 8)
    }
}

struct CastMemberView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCast = CastMember(
            id: 123,
            name: "Christian Bale",
            character: "Bruce Wayne / Batman",
            profilePath: "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg"
        )
        
        Group {
            CastMemberView(member: mockCast)
                .previewLayout(.sizeThatFits)
            
            CastMemberView(member: mockCast, imageSize: 80)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
