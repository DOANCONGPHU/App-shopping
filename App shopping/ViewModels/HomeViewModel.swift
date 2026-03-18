//
//  HomeView.swift
//  App shopping
//
//  Created by gem on 16/3/26.
//
import Foundation

class HomeViewModel {

    var filteredProducts: [Product] = []
    var banners: [Product] = []
    var products : [Product] = []
    var categories: [Category] = []
    
    var onProductsUpdated: (() -> Void)?
    var onCategoriesUpdated: (() -> Void)?
    var onBannersUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    func fetchAll() {
        fetchBanners()
        fetchCategories()
        fetchProducts()
    }
    func fetchBanners() {
        NetworkManager.shared.fetchBanners { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.banners = response.products
                self.onBannersUpdated?()
            case .failure(let error):
                self.onError?(self.errorMessage(error))
            }
        }
    }
    func fetchCategories() {
        NetworkManager.shared.fetchCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                let allCategory = Category(slug: "all", name: "All", url: "")
                self.categories = [allCategory] + categories
                self.onCategoriesUpdated?()
            case .failure(let error):
                self.onError?(self.errorMessage(error))
            }
        }
    }

    func fetchProducts() {
        onLoading?(true)
        NetworkManager.shared.fetchProducts { [weak self] result in
            guard let self = self else { return }
            self.onLoading?(false)
            switch result {
            case .success(let response):
                self.filteredProducts = response.products
                self.onProductsUpdated?()
            case .failure(let error):
                self.onError?(self.errorMessage(error))
            }
        }
    }

    func fetchCategoryDetail(category: Category) {
        if category.slug == "all" {
            fetchProducts()
            return
        }
        onLoading?(true)
        NetworkManager.shared.fetchCategoryDetail(category: category.slug) { [weak self] result in
            guard let self = self else { return }
            self.onLoading?(false)
            switch result {
            case .success(let response):
                self.filteredProducts = response.products
                self.onProductsUpdated?()
            case .failure(let error):
                self.onError?(self.errorMessage(error))
            }
        }
    }
    
    private func errorMessage(_ error: NetworkError) -> String {
        switch error {
        case .invalidURL:            return "URL không hợp lệ"
        case .noData:                return "Không có dữ liệu"
        case .decodingError:         return "Lỗi đọc dữ liệu"
        case .serverError(let code): return "Lỗi server: \(code)"
        }
    }
}
