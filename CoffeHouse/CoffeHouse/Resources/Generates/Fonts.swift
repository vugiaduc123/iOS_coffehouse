//
//  Fonts.swift
//  CoffeHouse
//
//  Created by Vũ Đức on 22/11/24.
//

import Foundation
#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Montserrat {
    internal static let bold = FontConvertible(name: "Montserrat-Bold", family: "Montserrat", path: "Montserrat-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Montserrat-BoldItalic", family: "Montserrat", path: "Montserrat-BoldItalic.ttf")
    internal static let italic = FontConvertible(name: "Montserrat-Italic", family: "Montserrat", path: "Montserrat-Italic.ttf")
    internal static let light = FontConvertible(name: "Montserrat-Light", family: "Montserrat", path: "Montserrat-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Montserrat-LightItalic", family: "Montserrat", path: "Montserrat-LightItalic.ttf")
    internal static let regular = FontConvertible(name: "Montserrat-Regular", family: "Montserrat", path: "Montserrat-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Montserrat-SemiBold", family: "Montserrat", path: "Montserrat-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "Montserrat-SemiBoldItalic", family: "Montserrat", path: "Montserrat-SemiBoldItalic.ttf")
    internal static let all: [FontConvertible] = [bold, boldItalic, italic, light, lightItalic, regular, semiBold, semiBoldItalic]
  }
    
  internal static let allCustomFonts: [FontConvertible] = [Montserrat.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
