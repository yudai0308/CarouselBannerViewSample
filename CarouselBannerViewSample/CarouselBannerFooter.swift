import UIKit

class CarouselBannerFooter: UICollectionReusableView {
    static let id = "CarouselBannerFooter"
    static let kind = "CarouselBannerFooterKind"
    
    var pageControl: UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pageControl = UIPageControl(frame: CGRect(origin: .zero, size: self.bounds.size))
        pageControl.pageIndicatorTintColor = UIColor.systemGray4
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        // デフォルトでは PageControl がタップできるが、不要なので外しておく
        pageControl.isUserInteractionEnabled = false
        self.addSubview(pageControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
