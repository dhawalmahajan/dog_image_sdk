//
//  File.swift
//  
//
//  Created by Dhawal Mahajan on 30/07/24.
//

import Foundation
@available(iOS 13.00, *)
@available(macOS 10.15, *)
class DogImageViewModel:DogImage {
    init()  {
        Task {
            await fetchDogImages()
        }
    }
    var apiURL: URL? {
        return URL(string: "https://dog.ceo/api/breeds/image/random")
    }
    
    func getImage() -> URL? {
        return images.first
    }
    
    func getNextImage() -> URL? {
        Task {
            await fetchDogImages()
        }
        guard currentIndex + 1 < images.count else { return nil }
        currentIndex += 1
        
        return images[currentIndex]
    }
    
    func getImages(number: Int) -> [URL] {
        return Array(images.prefix(number))
    }
    
    func getPreviousImage() -> URL? {
        
        guard currentIndex - 1 >= 0 else { return nil }
        currentIndex -= 1
        return images[currentIndex]
    }
    
   
    func fetchDogImages()  async {
        guard let url = apiURL else { return }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
             let dog = try JSONDecoder().decode(Dog.self, from: data)
            if let url = URL(string: dog.message) {
                images.append(url)
            }
            
        } catch {
            debugPrint(error.localizedDescription)
        }
       
    }
    
    var images: [URL] = []
    var currentIndex: Int = -1
}
