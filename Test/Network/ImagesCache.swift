//
//  ImagesCache.swift
//  Test
//
//  Created by Алексей Папин on 16.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit
import Nuke

class ImagesCache {
    var cache: [String: UIImageView] = [:]
    
    func load(paths: [String]) {
        for path in paths {
            guard let url = URL(string: path) else { continue }
            let imageView = UIImageView()
            Nuke.loadImage(with: url, into: imageView)
            cache.updateValue(imageView, forKey: path)
        }
    }
}
