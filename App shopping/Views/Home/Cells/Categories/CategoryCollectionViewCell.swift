//
//  Untitled.swift
//  App shopping
//
//  Created by gem on 16/3/26.
//
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        contentView.layer.cornerRadius = 8
       updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Category) {
        categoryLabel.text = category.name
    }
    
    private func updateUI() {
        if isSelected {
            contentView.backgroundColor = .systemBlue
            categoryLabel.textColor = .white
        } else {
            contentView.backgroundColor = .systemGray5
            categoryLabel.textColor = .black
        }
    }
}

