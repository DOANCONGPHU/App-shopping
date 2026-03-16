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

    var onProductsUpdated: (() -> Void)?
    var onCategoriesUpdated: (() -> Void)?
    var onBannersUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoading: ((Bool) -> Void)?
    
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
    private func errorMessage(_ error: NetworkError) -> String {
        switch error {
        case .invalidURL:            return "URL không hợp lệ"
        case .noData:                return "Không có dữ liệu"
        case .decodingError:         return "Lỗi đọc dữ liệu"
        case .serverError(let code): return "Lỗi server: \(code)"
        }
    }
}
