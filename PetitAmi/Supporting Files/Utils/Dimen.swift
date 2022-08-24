//
//  Dimen.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

class Dimen {
    public static let deviceHeight = UIScreen.main.bounds.height
    public static let deviceWidth = UIScreen.main.bounds.width
    public static let heightMultiplier: CGFloat = deviceHeight/812
    public static let widthMultiplier: CGFloat = deviceWidth/375
    public static let leadingMargin: CGFloat = 24*widthMultiplier
    public static let vertical64:CGFloat = 64*heightMultiplier
    public static let cellWidth: CGFloat = 90*widthMultiplier
    public static let cellHeight: CGFloat = 122*heightMultiplier
}
