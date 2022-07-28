import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
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
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case SectionType.carouselBanner.rawValue:
                return self.carouselBannerSection()
            default:
                fatalError()
            }
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        collectionView.dataSource = dataSource
        
        let sectionItems = images.map { SectionItem.carouselBannerCell($0!) }
        updateSnapshot(items: sectionItems, to: SectionType.carouselBanner)
    }
}
