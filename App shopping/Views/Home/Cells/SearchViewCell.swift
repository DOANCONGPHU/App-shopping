//
//  SearchBarCell.swift
//  App shopping
//
//  Created by gem on 13/3/26.
//
import UIKit

class SearchViewCell: UITableViewCell {
    static let indentifier = "SearchViewCell"
    let searchField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Search Products"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemGray5
        return tf
    }()
    
    let iconSearchView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        searchField.leftView = iconSearchView
        searchField.leftViewMode = .always
        contentView.addSubview(searchField)
        contentView.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            searchField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            searchField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            searchField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#Preview{
    SearchViewCell()
}
