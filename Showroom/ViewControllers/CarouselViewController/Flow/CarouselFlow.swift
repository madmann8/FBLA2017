import Foundation
import Device

class CarouselFlowLayout: PageCollectionLayout {
  
  static var cellSize: CGSize {
    if  Size.screen4Inch == Device.size() { return CGSize(width: 270, height: 352) }
    if  Size.screen3_5Inch == Device.size() { return CGSize(width: 270, height: 352) }
    return CGSize(width: 307, height: 400)
  } 
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    itemSize = CarouselFlowLayout.cellSize
    scrollDirection = .horizontal
    
  }
}
