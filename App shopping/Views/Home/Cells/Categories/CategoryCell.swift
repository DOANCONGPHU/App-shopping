//
//  CategoryCell.swift
//  App shopping
//
//  Created by gem on 13/3/26.
//
import UIKit

protocol CategoryDelegate : AnyObject{
    func didSelectCategory(_ category: Category)
}

class CategoryCell : UITableViewCell{
    weak var delegate : CategoryDelegate?
    private var isFirstLoad = true
    static let identifier: String = "CategoryViewCell"
    var collectionCategories : UICollectionView!
    private var category : [Category] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionCategories = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionCategories.delegate = self
        collectionCategories.dataSource = self
        collectionCategories.showsHorizontalScrollIndicator = false
        collectionCategories.translatesAutoresizingMaskIntoConstraints = false
        collectionCategories.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        contentView.addSubview(collectionCategories)
        NSLayoutConstraint.activate([
            collectionCategories.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionCategories.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionCategories.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionCategories.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        ])
    }
    
    func config(with category : [Category] ) {
        self.category = category
        self.collectionCategories.reloadData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell else{
            return UICollectionViewCell()
        }
        let category = category[indexPath.row]
        
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = category[indexPath.item]
        delegate?.didSelectCategory(selected)
    }
}
