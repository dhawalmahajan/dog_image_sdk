//
//  DogImageViewModelTest.swift
//  
//
//  Created by Dhawal Mahajan on 30/07/24.
//

import XCTest
@testable import DogImage
@available(macOS 10.15, *)
final class DogImageViewModelTest: XCTestCase {

    var viewModel: DogImageViewModel!

        override func setUp() {
            super.setUp()
            viewModel = DogImageViewModel()
        }

        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }

        func testAPIURL() {
            XCTAssertEqual(viewModel.apiURL, URL(string: "https://dog.ceo/api/breeds/image/random"))
        }

        func testFetchDogImages() async {
            await viewModel.fetchDogImages()
            XCTAssertFalse(viewModel.images.isEmpty, "Images should not be empty after fetching")
        }

        func testGetImage() async {
            await viewModel.fetchDogImages()
            let image = viewModel.getImage()
            XCTAssertNotNil(image, "There should be at least one image")
        }

        func testGetNextImage() async {
            await viewModel.fetchDogImages()
            let initialImage = viewModel.getImage()
            let nextImage = viewModel.getNextImage()
            XCTAssertNotEqual(initialImage, nextImage, "Next image should be different from the initial one")
        }

        func testGetPreviousImage() async {
            await viewModel.fetchDogImages()
            let firstImage = viewModel.getImage()
            _ = viewModel.getNextImage() // Advance to the next image
            let previousImage = viewModel.getPreviousImage()
            XCTAssertEqual(firstImage, previousImage, "Previous image should match the first image")
        }

        func testGetImages() async {
            await viewModel.fetchDogImages()
            let numberOfImages = 3
            let images = viewModel.getImages(number: numberOfImages)
            XCTAssertEqual(images.count, numberOfImages, "Should return the requested number of images")
        }

}
