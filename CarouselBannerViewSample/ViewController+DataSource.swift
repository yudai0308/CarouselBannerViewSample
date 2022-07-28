import UIKit

extension ViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, SectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionItem>
    
    func updateSnapshot(items: [SectionItem], to section: SectionType) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, sectionItem :SectionItem) -> UICollectionViewCell {
        switch sectionItem {
        case .carouselBannerCell(let image):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselBannerCell.id, for: indexPath) as! CarouselBannerCell
            cell.imageView.image = image
            
            return cell
        }
    }
    
    internal func carouselBannerSection() -> NSCollectionLayoutSection {
        // item, group の幅は画面幅と同じにする。
        // fractionalWidth(1.0) を使うとズレが発生する。
        let width = UIScreen.main.bounds.width
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    
}
