// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
protocol DogImage {
    var apiURL:URL? { get }
    func getImage() -> URL?
    func getNextImage() -> URL?
    func getImages(number: Int) -> [URL]
    func getPreviousImage() -> URL?
}

struct Dog: Decodable {
    let message:String
    let status:String
}


@available(macOS 10.15, *)
final class DogImageLibrary {
    let viewModel: DogImageViewModel?
    
    init(viewModel: DogImageViewModel = DogImageViewModel()) {
        self.viewModel = viewModel
        Task {
                await fetchDogImages()
        }
    }
    
     func fetchDogImages() async {
        // Replace with your actual API URL
        await viewModel?.fetchDogImages()
    }
    
    func getImage() -> URL? {
        viewModel?.getImage()
    }
    
    func getImages(number: Int) -> [URL] {
        viewModel?.getImages(number: number) ?? []
    }
    
    func getNextImage() -> URL? {
        viewModel?.getNextImage()
    }
    
    func getPreviousImage() -> URL? {
        viewModel?.getPreviousImage()
    }
}
