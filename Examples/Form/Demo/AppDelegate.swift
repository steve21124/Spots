import UIKit
import Spots

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    GridSpot.cells["field"] = GridFieldCell.self
    GridSpot.customLayout = LeftAlignedLayout()

    let component = Component(title: "Form", items: [
      ListItem(title: "Firstname", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Lastname", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Dispay name", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Social security number", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Country code", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Address", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Postal code", kind: "field", size: CGSize(width: 200, height: 50)),
      ListItem(title: "Phone number", kind: "field", size: CGSize(width: 300, height: 50)),
      ListItem(title: "Email adress", kind: "field", size: CGSize(width: 300, height: 50)),
      ListItem(title: "Bank account", kind: "field", size: CGSize(width: 300, height: 50)),
      ])
    let gridSpot = GridSpot(component, top: 20, left: 20, right: 20, bottom: 20)
    let controller = FormController(spots: [
      TitleSpot(title: "Form"),
      gridSpot
      ])

    navigationController = UINavigationController(rootViewController: controller)
    window?.rootViewController = navigationController

    applyStyles()
    
    window?.makeKeyAndVisible()
    
    return true
  }

  func applyStyles() {
    UIApplication.sharedApplication().statusBarStyle = .LightContent

    let navigationBar = UINavigationBar.appearance()
    navigationBar.barTintColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha: 1)
    navigationBar.tintColor = UIColor(red:1.000, green:1.000, blue:1.000, alpha: 1)
    navigationBar.shadowImage = UIImage()
    navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName: UIColor(red:1.000, green:1.000, blue:1.000, alpha: 1)
    ]
  }
}

