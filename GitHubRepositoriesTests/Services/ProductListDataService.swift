//
//  ProductListDataService_Test.swift
//  IOSTaskTests
//
//  Created by Farido on 20/09/2024.
//

import XCTest
import Combine
@testable import IOSTask

final class ProductListDataServiceClient:  ProductListDataServiceProtocol, Mockable {

    let filename: String

    init(filename: String) {
        self.filename = filename
    }

    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return loadJson(filename: filename, extensionType: .json, responseModel: [CategoryModel].self)
    }

    func getProducts(byCategory: String?) -> AnyPublisher<IOSTask.ProductsModel, Error> {
        return loadJson(filename: filename, extensionType: .json, responseModel: ProductsModel.self)
    }

    func loadMoreItem(limit: Int, skip: Int, byCategory: String?) -> AnyPublisher<IOSTask.ProductsModel, Error> {
        return loadJson(filename: filename, extensionType: .json, responseModel: ProductsModel.self)
    }

    func getProductDetails(productId: Int) -> AnyPublisher<IOSTask.Product, Error> {
        return loadJson(filename: filename, extensionType: .json, responseModel: Product.self)
    }
}

