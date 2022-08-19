//
//  AlertController.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import UIKit

class Alert {
    static func alertToCorrect(title: String, message: String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
        controller.present(alertController, animated: true)
    }
}
