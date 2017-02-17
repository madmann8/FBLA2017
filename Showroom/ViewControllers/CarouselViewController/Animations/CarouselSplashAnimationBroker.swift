import UIKit
import EasyPeasy

struct CarouselSplashAnimationBroker {
  
  let collectionView: UICollectionView
  let donateDirectlyButton: UIButton
  let pageLabel: UILabel
  let titleContainer: CarouselTitleView
  let topRectangle: UIImageView
  let bottomRectangle: UIImageView
  let backgroudView: UIView
  let bottomContainer: UIView
  
  init(collectionView: UICollectionView,
       donateDirectlyButton: UIButton,
       pageLabel: UILabel,
       titleContainer: CarouselTitleView,
       topRectangle: UIImageView,
       bottomRectangle: UIImageView,
       backgroudView: UIView,
       bottomContainer: UIView) {
    
    self.collectionView = collectionView
    self.donateDirectlyButton = donateDirectlyButton
    self.pageLabel = pageLabel
    self.titleContainer = titleContainer
    self.topRectangle = topRectangle
    self.bottomRectangle = bottomRectangle
    self.backgroudView = backgroudView
    self.bottomContainer = bottomContainer
    
    [collectionView, titleContainer.rLogo, titleContainer.ramotionLabel, donateDirectlyButton, pageLabel].forEach { $0.alpha = 0 }
  }
}

extension CarouselSplashAnimationBroker {
  
  func startAnimations() {
    rLogoAnimation()
    ramotionLogoAnimation()
    
    backgroundAnimation()
    donateDirectlyButtonAnimation()
    collectionViewAnimation()
    
    pageLabel.animate(duration: 0.4, delay: 2.5, [.alpha(to: 1)], timing: .easyInEasyOut)
  }
}

private extension CarouselSplashAnimationBroker {
  
  func rLogoAnimation() {
    let rLogoStartPosition = titleContainer.rLogo.layer.position
    titleContainer.rLogo.animate(duration: 0.001, [.layerPositionXY(from: YardSale.screenCenter, to: YardSale.screenCenter), .alpha(to: 1)])
    
    titleContainer.rLogo.animationImages = (0...36).flatMap { UIImage(named: ($0 < 9) ? "FBLAIcon" : "FBLAIcon") }
    titleContainer.rLogo.animationDuration = 1.2
    titleContainer.rLogo.animationRepeatCount = 1
    titleContainer.rLogo.startAnimating()
    
    titleContainer.rLogo.animate(duration: 0.8, delay: 1.3, [.layerPositionX(from: YardSale.screenCenter.x, to: rLogoStartPosition.x)], timing: .easyInEasyOut) {
      self.titleContainer.rLogo.layer.shouldRasterize = true
    }
    titleContainer.rLogo.animate(duration: 0.7, delay: 2.2, [.layerPositionY(from: YardSale.screenCenter.y, to: rLogoStartPosition.y)], timing: .easyInEasyOut){
      self.titleContainer.rLogo.layer.shouldRasterize = false
    }
  }
  
  func ramotionLogoAnimation() {
    guard let ramotionImage = titleContainer.ramotionLabel.image else { return }

    let ramotionLabelStartPosition = titleContainer.ramotionLabel.layer.position

    
    let xHidePosition = YardSale.screen.width + ramotionImage.size.width / 2
    let hidePosition = CGPoint(x: xHidePosition, y: YardSale.screenCenter.y)
    titleContainer.ramotionLabel.animate(duration: 0.001, [.layerPositionXY(from: hidePosition, to: hidePosition), .alpha(to: 1)])
    titleContainer.ramotionLabel.animate(duration: 0.8, delay: 1.4, [.layerPositionX(from: xHidePosition, to: ramotionLabelStartPosition.x)], timing: .easyInEasyOut)
    titleContainer.ramotionLabel.animate(duration: 0.7, delay: 2.23, [.layerPositionY(from: YardSale.screenCenter.y, to: ramotionLabelStartPosition.y)], timing: .easyInEasyOut)
  }
  
    
  func backgroundAnimation() {
    backgroudView.backgroundColor = UIColor(red:0/255, green:58/255, blue:132/255, alpha:1.00)
    backgroudView.animate(duration: 0.8, delay: 0.5, [.color(to: UIColor(red: 0.9137, green: 0.4, blue: 0.3373, alpha: 1.0))])
  }
  
  func donateDirectlyButtonAnimation() {
    let startPosition = donateDirectlyButton.layer.position
    let hidePosition = bottomContainer.bounds.size.height + donateDirectlyButton.bounds.height / 2
    donateDirectlyButton.animate(duration: 0.001, [
      .layerPositionY(from: hidePosition , to: hidePosition),
      .alpha(to: 1)
      ])
    
    donateDirectlyButton.animate(duration: 0.8,
                            delay: 2.2,
                            [.layerPositionY(from: hidePosition, to: startPosition.y)],
                            timing: .easyInEasyOut) 
  }
  
  func collectionViewAnimation() {
    let startPositionX = collectionView.layer.position.x
    let hidePosition = collectionView.bounds.size.width / 2 + YardSale.screen.width
    collectionView.animate(duration: 0.001, [.layerPositionX(from: hidePosition, to: hidePosition), .alpha(to: 1)])
    collectionView.layer.shouldRasterize = true
    
    collectionView.animate(duration: 0.5,
                            delay: 2.5,
                            [.layerPositionX(from: hidePosition, to: startPositionX)],
                            timing: .easyInEasyOut) { _ in
                              self.collectionView.layer.shouldRasterize = false
                            }
  }
}
