//
//  URLs.swift
//  Madhuri Assignment
//
//  Created by Madhuri Agrawal on 04/08/19.
//  Copyright © 2019 Madhuri Agrawal. All rights reserved.
//

import Foundation
import UIKit


 struct URLs {
    static var mostviewedAPI = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=%@"
    static var searchArticleAPI = "https://api.themoviedb.org/3/movie/now_playing?api_key=%@&language=en-US&page="
}

extension String {
   
    func localized() -> String {
        return NSLocalizedString(self, bundle: .main, comment: self)
    }
}

extension UIViewController {
    //toast for message alert.
    func showToast(message : String) {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: 50, y: UIScreen.main.bounds.height-100, width:UIScreen.main.bounds.width - 100, height: 40))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont.systemFont(ofSize: 12)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.window?.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
}

// MARK: - Photo
class ProfilePhoto: Codable {
    let id: String
    let url: String?
    var imageData: Data?
    var image : UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return UIImage(named: "placeholder")
    }
    lazy var photoState: PhotoRecordState? = .new

    init(id: Int, url: String?) {
        self.id = "\(id)"
        self.url = url
    }
}
