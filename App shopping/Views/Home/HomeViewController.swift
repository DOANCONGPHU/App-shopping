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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpLayout()
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewCell.indentifier, for: indexPath) as! SearchViewCell
        return cell
    }
}
#Preview {
    UINavigationController(rootViewController: HomeViewController())
}
