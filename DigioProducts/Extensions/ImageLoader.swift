//
//  ImageLoader.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class ImageLoader {
    
    static let shared = ImageLoader()
        
    private init() {}
    
    private var tasks: [URL: URLSessionDataTask] = [:]
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        tasks[url]?.cancel()
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error as? URLError, error.code == .cancelled {
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(UIImage(named: "ic_fail"))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        tasks[url] = task
        task.resume()
    }
    
    func cancelLoading(from url: URL) {
        tasks[url]?.cancel()
        tasks[url] = nil
    }
    
    func cancelAll() {
        tasks.forEach { _, task in
            task.cancel()
        }
        tasks.removeAll()
    }
}
