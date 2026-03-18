//
//  BannerCell.swift
//  App shopping
//
//  Created by gem on 13/3/26.
//
import UIKit

class BannerCell: UITableViewCell{
    static let identifier: String = "BannerViewCell"
    var collectionBanner : UICollectionView!
    private var banners : [Product] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0      

        collectionBanner = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionBanner.contentInset = .zero
        collectionBanner.isPagingEnabled = true
        collectionBanner.showsHorizontalScrollIndicator = false
        collectionBanner.translatesAutoresizingMaskIntoConstraints = false
        collectionBanner.delegate = self
        collectionBanner.dataSource = self
        collectionBanner.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        contentView.addSubview(collectionBanner)

        //auto layout
        NSLayoutConstraint.activate([
            collectionBanner.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionBanner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
       
    }
    func configure(with banners: [Product]) {
        self.banners = banners
        collectionBanner.reloadData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension BannerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionBanner.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let banner = banners[indexPath.row]
        cell.configure(with: banner)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
}
