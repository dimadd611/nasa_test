//
//  Alert.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit


extension UIViewController {
    
    public func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        UIAlertAction(title: "Cancel", style: .cancel)
        
        self.present(alert, animated: true)
    }
}
