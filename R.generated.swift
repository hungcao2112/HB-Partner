//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `primary_red`.
    static let primary_red = Rswift.ColorResource(bundle: R.hostingBundle, name: "primary_red")
    
    /// `UIColor(named: "primary_red", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func primary_red(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.primary_red, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `ic_tabbar_closed`.
    static let ic_tabbar_closed = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_tabbar_closed")
    /// Image `ic_tabbar_new`.
    static let ic_tabbar_new = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_tabbar_new")
    /// Image `ic_tabbar_processing`.
    static let ic_tabbar_processing = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_tabbar_processing")
    /// Image `ic_tabbar_settings`.
    static let ic_tabbar_settings = Rswift.ImageResource(bundle: R.hostingBundle, name: "ic_tabbar_settings")
    
    /// `UIImage(named: "ic_tabbar_closed", bundle: ..., traitCollection: ...)`
    static func ic_tabbar_closed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_tabbar_closed, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_tabbar_new", bundle: ..., traitCollection: ...)`
    static func ic_tabbar_new(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_tabbar_new, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_tabbar_processing", bundle: ..., traitCollection: ...)`
    static func ic_tabbar_processing(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_tabbar_processing, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "ic_tabbar_settings", bundle: ..., traitCollection: ...)`
    static func ic_tabbar_settings(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.ic_tabbar_settings, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Login`.
    static let login = _R.storyboard.login()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Login", bundle: ...)`
    static func login(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.login)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try login.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
          if UIKit.UIColor(named: "primary_red", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'primary_red' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        }
      }
      
      fileprivate init() {}
    }
    
    struct login: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = LoginViewController
      
      let bundle = R.hostingBundle
      let name = "Login"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
          if UIKit.UIColor(named: "primary_red", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'primary_red' is used in storyboard 'Login', but couldn't be loaded.") }
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainViewController
      
      let bundle = R.hostingBundle
      let mainViewController = StoryboardViewControllerResource<MainViewController>(identifier: "MainViewController")
      let name = "Main"
      let newViewController = StoryboardViewControllerResource<NewViewController>(identifier: "NewViewController")
      
      func mainViewController(_: Void = ()) -> MainViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainViewController)
      }
      
      func newViewController(_: Void = ()) -> NewViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "ic_tabbar_closed", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_tabbar_closed' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_tabbar_new", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_tabbar_new' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_tabbar_processing", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_tabbar_processing' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "ic_tabbar_settings", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'ic_tabbar_settings' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
          if UIKit.UIColor(named: "primary_red", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'primary_red' is used in storyboard 'Main', but couldn't be loaded.") }
        }
        if _R.storyboard.main().mainViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainViewController' could not be loaded from storyboard 'Main' as 'MainViewController'.") }
        if _R.storyboard.main().newViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newViewController' could not be loaded from storyboard 'Main' as 'NewViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
