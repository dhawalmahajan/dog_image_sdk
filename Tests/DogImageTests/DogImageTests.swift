import XCTest
@testable import DogImage

@available(macOS 10.15, *)
final class DogImageTests: XCTestCase {
    var dogImageLibrary: DogImageLibrary!
       var mockViewModel: MockDogImageViewModel!

       override func setUp() {
           super.setUp()
           mockViewModel = MockDogImageViewModel()
           dogImageLibrary = DogImageLibrary(viewModel: mockViewModel)
       }

       override func tearDown() {
           dogImageLibrary = nil
           mockViewModel = nil
           super.tearDown()
       }

       func testGetImage() async {
           await dogImageLibrary.fetchDogImages()
           let image = dogImageLibrary.getImage()
           XCTAssertNotNil(image, "There should be an image returned")
           XCTAssertEqual(image, mockViewModel.images.first, "The image returned should be the first image in the view model")
       }

       func testGetImages() async {
           await dogImageLibrary.fetchDogImages()
           let numberOfImages = 2
           let images = dogImageLibrary.getImages(number: numberOfImages)
           XCTAssertEqual(images.count, numberOfImages, "Should return the requested number of images")
           XCTAssertEqual(images, Array(mockViewModel.images.prefix(numberOfImages)), "Returned images should match the first few images in the view model")
       }

       func testGetNextImage() async {
           await dogImageLibrary.fetchDogImages()
           let nextImage = dogImageLibrary.getNextImage()
           XCTAssertEqual(nextImage, mockViewModel.images[1], "The next image should be the second image in the view model")
       }

       func testGetPreviousImage() async {
           await dogImageLibrary.fetchDogImages()
           _ = dogImageLibrary.getNextImage() // Advance to the next image
           let previousImage = dogImageLibrary.getPreviousImage()
           XCTAssertEqual(previousImage, mockViewModel.images.first, "The previous image should be the first image in the view model")
       }
}
// Mock class for DogImageViewModel
@available(macOS 10.15, *)
class MockDogImageViewModel: DogImageViewModel {
    override init() {
        super.init()
        // Prepopulate with mock data
        self.images = [
            URL(string: "https://example.com/dog1.jpg")!,
            URL(string: "https://example.com/dog2.jpg")!,
            URL(string: "https://example.com/dog3.jpg")!
        ]
        self.currentIndex = 0
    }

    override func fetchDogImages() async {
        // Do nothing for now or simulate fetching data
    }
}
