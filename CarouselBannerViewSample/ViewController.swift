import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    internal var carouselBannerFooter: CarouselBannerFooter?
    
    enum SectionType: Int {
        case carouselBanner = 0
    }
    
    enum SectionItem: Hashable {
        case carouselBannerCell(UIImage)
    }
    
    var dataSource: DataSource!
    
    let images = [
        UIImage(named: "building"),
        UIImage(named: "flowers"),
        UIImage(named: "mountains"),
        UIImage(named: "dog"),
        UIImage(named: "boat")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CarouselBannerCell.self, forCellWithReuseIdentifier: CarouselBannerCell.id)
        collectionView.register(CarouselBannerFooter.self, forSupplementaryViewOfKind: CarouselBannerFooter.kind, withReuseIdentifier: CarouselBannerFooter.id)

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = supplementaryViewProvider
        collectionView.dataSource = dataSource
        
        let sectionItems = images.map { SectionItem.carouselBannerCell($0!) }
        updateSnapshot(items: sectionItems, to: SectionType.carouselBanner)
    }
}
