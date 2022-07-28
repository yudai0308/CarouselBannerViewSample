import UIKit

class CarouselBannerCell : UICollectionViewCell {
    static let id = "CarouselBannerCell"
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 200)))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
