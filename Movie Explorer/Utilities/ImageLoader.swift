//
//  ImageLoader.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private static let cache = NSCache<NSString, UIImage>()
    
    func load(fromURLString urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        // Return cached image if available
        if let cachedImage = Self.cache.object(forKey: cacheKey) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: "\(Constants.imageBaseURL)\(urlString)") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let image = $0 else { return }
                Self.cache.setObject(image, forKey: cacheKey)
                self?.image = image
            }
    }
}
