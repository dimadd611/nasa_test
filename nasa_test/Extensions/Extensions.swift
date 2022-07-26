//
//  Extensions.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0)}
    }
}


extension UIApplication {
  class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
    if let nav = base as? UINavigationController {
      return getTopViewController(base: nav.visibleViewController)
    } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
      return getTopViewController(base: selected)
    } else if let presented = base?.presentedViewController {
      return getTopViewController(base: presented)
    } else if let search = base as? UISearchController {
      return search.next as? UIViewController
    }
    return base
  }
  
  static var presentedViewController: UIViewController? {
    var presentViewController = UIApplication.shared.keyWindow?.rootViewController
    while let pVC = presentViewController?.presentedViewController {
      presentViewController = pVC
    }
    return presentViewController
  }
  
  static var applicationVersion: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
  }
  
  static var applicationBuild: String {
    return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
  }
  
  static var versionBuild: String {
    return "v\(self.applicationVersion)(\(self.applicationBuild))"
  }
}
