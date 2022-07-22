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
