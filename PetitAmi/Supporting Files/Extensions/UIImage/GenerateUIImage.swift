//
//  GenerateUIImage.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/18/22.
//

import UIKit

extension UIImage {
    public static var logo: UIImage { imageBuilder("logo") }
    public static var books: UIImage { imageBuilder("books") }
    public static var house: UIImage { UIImage(systemName: "house.fill")! }
    public static var person: UIImage { UIImage(systemName: "person.circle.fill")! }
    public static var library: UIImage { UIImage(systemName: "book.fill")! }
    public static var header: UIImage { imageBuilder("header") }
    public static var speaker: UIImage { UIImage(systemName: "speaker.fill")! }
    public static var speakerLoading: UIImage { UIImage(systemName: "speaker.badge.exclamationmark.fill")! }
    public static var speakerPlaying: UIImage { UIImage(systemName: "speaker.wave.3.fill")! }
    public static var mic: UIImage { UIImage(systemName: "mic.fill")! }
    public static var logout: UIImage { UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!}
}
