//  
//  UIImageView+setImage.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {

	typealias ImageType = Resource?

    func setImage(_ image: ImageType) {
        guard let _resource = image else { return }
        var kf = self.kf
        kf.indicatorType = IndicatorType.activity
        kf.setImage(with: _resource)
    }

}
