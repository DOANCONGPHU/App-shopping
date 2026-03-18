//
//  BannerCollectionViewCell.swift
//  App shopping
//
//  Created by gem on 16/3/26.
//
import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    private let imageBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageBanner)
        imageBanner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageBanner.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            imageBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        contentView.backgroundColor = .white

        imageBanner.backgroundColor = .systemGray6
        imageBanner.layer.cornerRadius = 12        
        imageBanner.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with banners: Product) {
        if let bannerUrl = URL(string: banners.thumbnail) {
            URLSession.shared.dataTask(with: bannerUrl){data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageBanner.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
