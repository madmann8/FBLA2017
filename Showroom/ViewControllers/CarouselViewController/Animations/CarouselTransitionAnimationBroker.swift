import UIKit

class CarouselTransitionAnimationBroker {
  
  let collectionView: UICollectionView
  let donateDirectlyButton: UIButton
  let pageLabel: UILabel
  let titleContainer: CarouselTitleView
  let bottomContainer: UIView
  
  fileprivate var donateDirectlyButtonPositionY: CGFloat = 0
  
  init(collectionView: UICollectionView,
       donateDirectlyButton: UIButton,
       pageLabel: UILabel,
       titleContainer: CarouselTitleView,
       bottomContainer: UIView) {
    self.collectionView = collectionView
    self.donateDirectlyButton = donateDirectlyButton
    self.pageLabel = pageLabel
    self.titleContainer = titleContainer
    self.bottomContainer = bottomContainer
  }
}

extension CarouselTransitionAnimationBroker {
  
  func showTranstion(collectionItemIndex: Int) {
    donateDirectlyButtonAnimation(hidden: true)
    pageLabelAnimation(hidden: true)
    titleAnimation(hidden: true)
    collectionViewAnimation(hidden: true, index: collectionItemIndex)
  }
  
  func hideTranstion(collectionItemIndex: Int) {
    donateDirectlyButtonAnimation(hidden: false)
    pageLabelAnimation(hidden: false)
    titleAnimation(hidden: false)
    collectionViewAnimation(hidden: false, index: collectionItemIndex)
  }
}

private extension CarouselTransitionAnimationBroker {
  
  func donateDirectlyButtonAnimation(hidden: Bool) {
    
    let startPosition: CGFloat
    let hidePosition: CGFloat
    if hidden {
      donateDirectlyButtonPositionY = donateDirectlyButton.layer.position.y
      startPosition = donateDirectlyButtonPositionY
      hidePosition = bottomContainer.bounds.size.height + donateDirectlyButton.bounds.height / 2
    } else {
      hidePosition = donateDirectlyButtonPositionY
      startPosition = bottomContainer.bounds.size.height + donateDirectlyButton.bounds.height / 2
    }
    
    donateDirectlyButton.animate(duration: 0.3, [
      .layerPositionY(from: startPosition , to: hidePosition),
      ],
      timing: .easyIn)
  }
  
    
  func pageLabelAnimation(hidden: Bool) {
    let alpha: CGFloat = hidden == true ? 0 : 1
    pageLabel.animate(duration: 0.3, [.alpha(to: alpha)], timing: .easyInEasyOut)
  }
  
  func titleAnimation(hidden: Bool) {
    let to, from: CGFloat
    if hidden == true {
      to = -titleContainer.rLogo.bounds.height / 2
      from = titleContainer.rLogo.center.y
    } else {
      from = -titleContainer.rLogo.bounds.height / 2
      to = titleContainer.center.y
    }
    
    titleContainer.rLogo.animate(duration: 0.3, [.layerPositionY(from: from, to: to)], timing: .easyInEasyOut)
    titleContainer.ramotionLabel.animate(duration: 0.3, [.layerPositionY(from: from, to: to)], timing: .easyInEasyOut)
  }
  
  func collectionViewAnimation(hidden: Bool, index: Int) {
    guard let item = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) else { return }
    let from, to: CGFloat
    if hidden == true {
      from = 1
      to = 2
    } else {
      from = 2
      to = 1
    }
    item.animate(duration: 0.5, [.viewScale(from: from, to: to)], timing: .easyInEasyOut) 
  }
}
