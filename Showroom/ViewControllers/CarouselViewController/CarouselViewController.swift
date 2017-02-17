             import UIKit
import EasyPeasy
import Device

extension UINavigationController {
  
  override open var shouldAutorotate: Bool {
    return false
  }
}

fileprivate struct C {
  
  static let radius: CGFloat = 5
}

class CarouselViewController: UIViewController {
  
  @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
  @IBOutlet weak var bottomRectangle: UIImageView!
  @IBOutlet weak var topRectangle: UIImageView!
  @IBOutlet weak var topContainer: CarouselTitleView!
  @IBOutlet weak var donateDirectlyButton: UIButton!
  @IBOutlet weak var pageLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var bottomContainer: UIView!
  
  fileprivate var isSplashAnimation = true
  
  fileprivate let items: [YardSale.Control] = [
                                               .donateView,
//                                               .browseItemsView,
                                               .aboutFBLAView,

    ]
  
  fileprivate var splashBrokerAnimation: CarouselSplashAnimationBroker!
  fileprivate var transitionBrokerAnimation: CarouselTransitionAnimationBroker?
  
  fileprivate var foldingCellVC: UIViewController!

  fileprivate var currentIndex: Int {
    guard let collectionView = self.collectionView else { return 0 }
    
    let startOffset = (collectionView.bounds.size.width - CarouselFlowLayout.cellSize.width) / 2
    guard let collectionLayout  = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
      return 0
    }
    
    let minimumLineSpacing = collectionLayout.minimumLineSpacing
    let a = collectionView.contentOffset.x + startOffset + CarouselFlowLayout.cellSize.width / 2
    let b = CarouselFlowLayout.cellSize.width + minimumLineSpacing
    return Int(a / b)
  }
    @IBAction func handleDonateDirectly(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://www.paypal.com")! as URL)

    }
}

extension CarouselViewController {
  
  override open var shouldAutorotate: Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.isStatusBarHidden = true
    
    collectionViewHeight.constant = CarouselFlowLayout.cellSize.height
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    
    splashBrokerAnimation = CarouselSplashAnimationBroker(collectionView: collectionView,
                                                          donateDirectlyButton: donateDirectlyButton,
                                                          pageLabel: pageLabel,
                                                          titleContainer: topContainer,
                                                          topRectangle: topRectangle,
                                                          bottomRectangle: bottomRectangle,
                                                          backgroudView: self.view,
                                                          bottomContainer: bottomContainer)
    
    transitionBrokerAnimation = CarouselTransitionAnimationBroker(collectionView: collectionView,
                                                                  donateDirectlyButton: donateDirectlyButton,
                                                                  pageLabel: pageLabel,
                                                                  titleContainer: topContainer,
                                                                  bottomContainer: bottomContainer)
    configureContactButton()
    pageLabel.text = "\(currentIndex + 1)/\(items.count)"
    collectionView.layer.masksToBounds = false
    
    if #available(iOS 10.0, *) {
      collectionView?.isPrefetchingEnabled = false
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if isSplashAnimation == true {
      splashBrokerAnimation.startAnimations()
      isSplashAnimation = false
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
}

extension  CarouselViewController {
  
  func configureContactButton() {
    donateDirectlyButton.layer.cornerRadius = C.radius
    donateDirectlyButton.layer.shadowColor = UIColor.black.cgColor
    donateDirectlyButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    donateDirectlyButton.layer.shadowRadius = 4
    donateDirectlyButton.layer.shadowOpacity = 0.3
  }
  
   

}

extension CarouselViewController {
  
  func transitionController(isOpen: Bool) {
    if isOpen == true {
      transitionBrokerAnimation?.showTranstion(collectionItemIndex: currentIndex)
    } else {
      transitionBrokerAnimation?.hideTranstion(collectionItemIndex: currentIndex)
    }
  }
}

extension CarouselViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard case let cell as ControlCollectionViewCell = cell else { return }
    cell.setInfo(control: items[indexPath.row])
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.getReusableCellWithIdentifier(indexPath: indexPath) as ControlCollectionViewCell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let page = "\(currentIndex + 1)/\(items.count)"
    if pageLabel.text != page { pageLabel.text = page }
  }
    
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    
    
    let vc: UIViewController
     vc = item.viewController
    

    vc.transitioningDelegate = self
    vc.modalPresentationStyle = .custom
    present(vc, animated: true) { [weak vc] in
      guard let vc = vc else { return }

    }
  }
}


extension CarouselViewController: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return OpenControllerTransition(duration: 1)
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return HideControllerTransition(duration: 0.5)
  }
}
