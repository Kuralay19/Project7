//
//  UIImageViewDownloaded.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 27.01.2024.
//

import UIKit
extension UIImageView {
    private func downloaded( from url : URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as?HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {return}
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
                
        }.resume()
    }
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit
    ) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
