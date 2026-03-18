//
//  HomeViewController.swift
//  App shopping
//     ├── SearchBarCell
//     ├── BannerCell
//     ├── CategoryCell
//     └── ProductCell
//  Created by gem on 12/3/26.
//

import UIKit

class HomeViewController: UIViewController{
    let tableView = UITableView()
    let viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpLayout()
        // section 0
        viewModel.onBannersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
        viewModel.onCategoriesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
        // section 1
        viewModel.onProductsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
        }
        
        viewModel.fetchAll()
    }
    func setUpUI(){
        //AppBAr
        navigationItem.title = "ShopDemo"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 32, weight: .bold),
            .foregroundColor: UIColor.systemBlue
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let cartButton = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(openCart)
        )
        navigationItem.rightBarButtonItem = cartButton
        //Content
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.indentifier)
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    func setUpLayout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    @objc func openCart() {
        print("Cart tapped")
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, CategoryDelegate{
    func didSelectCategory(_ category: Category) {
        viewModel.fetchCategoryDetail(category: category)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return viewModel.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Search + Banner + Categories
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.indentifier, for: indexPath) as! SearchViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
                cell.configure(with: viewModel.banners)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
                cell.config(with: viewModel.categories)
                cell.delegate = self
                return cell
            default:
                return UITableViewCell()
            }
        }
        //Products
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.configure(with: viewModel.filteredProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                return 230
            }
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        let product = viewModel.filteredProducts[indexPath.row]
        let detailVC = ProductDetail()
        detailVC.productID = product.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
#Preview {
    UINavigationController(rootViewController: HomeViewController())
}
