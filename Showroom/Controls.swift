import Foundation
import UIKit

extension YardSale.Control {
  
  var title: String {
    switch self {
    case .donateView: return "Donate Items"
    case .aboutFBLAView: return "About"
//    case .browseItemsView: return "Browse Items"

    }
  }
  
  var info: String {
    switch self {
    case .donateView: return "Donate item to be sold as part of the digital yard sale. Items must incluse a picture, suggested price, and a rating for the condition of the item."
    case .aboutFBLAView: return "Learn about FBLA—Futute Buisness Leaders of America and the importance of the organization."
//    case .browseItemsView: return "Browse items donated by the community for the yard sale. All profit goes towards assisting students in attending the NLC."

    }
  }
  
  
  var sharedURL: String {
    switch self {
    case .donateView: return "https://github.com/Ramotion/paper-switch"
    case .aboutFBLAView: return "https://github.com/Ramotion/paper-onboarding"
//    case .browseItemsView: return "https://github.com/Ramotion/expanding-collection"
    }
  }
  
      
    var image: String {
        switch self {
        case .donateView: return "Donate"
        case .aboutFBLAView: return "FBLALogo"
//        case .browseItemsView: return "Browse"

        }
    }
  
  var viewController: UIViewController {
    let main = UIStoryboard(storyboard: .Main)
    
    
    switch self {
    case .donateView: return UINavigationController(rootViewController: main.instantiateViewController() as DonateViewController)
    case .aboutFBLAView: return UINavigationController(rootViewController: main.instantiateViewController() as OnboardingViewController)
//    case .browseItemsView: return UINavigationController(rootViewController: main.instantiateViewController() as MainBrowseViewController)
    }
  }
}


extension UIStoryboard {
    
    enum Storyboard : String {
        case Main
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

extension UIViewController : StoryboardIdentifiable { }

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
