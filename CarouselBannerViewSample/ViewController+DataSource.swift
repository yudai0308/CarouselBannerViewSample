import UIKit

extension ViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, SectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, SectionItem>
    typealias DidChangePage = (Int) -> Void

    func updateSnapshot(sectionData: Dictionary<SectionType, [SectionItem]>) {
        var snapshot = Snapshot()
        let sections = Array(sectionData.keys)
        snapshot.appendSections(sections)
        for data in sectionData {
            snapshot.appendItems(data.value, toSection: data.key)
        }
        dataSource.apply(snapshot)
    }
    
    func sectionProvider(sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        switch sectionIndex {
        case SectionType.carouselBanner.rawValue:
            return self.carouselBannerSection { page in
                self.carouselBannerFooter?.pageControl.currentPage = page
            }
        default:
            fatalError()
        }
    }
    
    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, sectionItem :SectionItem) -> UICollectionViewCell {
        switch sectionItem {
        case .carouselBannerCell(let image):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselBannerCell.id, for: indexPath) as! CarouselBannerCell
            cell.imageView.image = image
            
            return cell
        }
    }
    
    func supplementaryViewProvider(collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView {
        switch elementKind {
        case CarouselBannerFooter.kind:
            carouselBannerFooter = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: CarouselBannerFooter.id, for: indexPath) as? CarouselBannerFooter
            carouselBannerFooter?.pageControl.numberOfPages = images.count
            return carouselBannerFooter!
        default:
            return UICollectionReusableView()
        }
    }
    
    func carouselBannerSection(didChangePage: @escaping DidChangePage) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
            
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: CarouselBannerFooter.kind, alignment: .bottom)
        section.boundarySupplementaryItems = [footer]
        
        section.visibleItemsInvalidationHandler = { (visibleItems, offset, env) in
            guard offset.x >= 0 else { return }
            let contentWidth = env.container.contentSize.width
            if (offset.x.remainder(dividingBy: contentWidth) == 0.0) {
                let page = offset.x / contentWidth
                didChangePage(Int(page))
            }
        }
        
        return section
    }
}
