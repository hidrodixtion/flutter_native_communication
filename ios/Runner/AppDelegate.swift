import UIKit
import Flutter
import Alamofire
import SwiftyJSON
import JGProgressHUD

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var flutterVC: FlutterViewController!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    initMethodChannel()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func initMethodChannel() {
        flutterVC = window?.rootViewController as! FlutterViewController
        
        let channel = FlutterMethodChannel(name: "flutter.testfairy.com/hello", binaryMessenger: flutterVC)
        
        channel.setMethodCallHandler { [unowned self] (methodCall, result) in
            guard let arg = (methodCall.arguments as! [String]).first else { return }
            
            switch methodCall.method {
            case "openPage":
                self.openSecondPage(param: arg)
            case "showDialog":
                self.openAlert(param: arg, result: result)
            case "request":
                self.callApi(url: arg, result: result)
            default:
                debugPrint(methodCall.method)
                result(methodCall.method)
            }
        }
    }
    
    private func openSecondPage(param: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nav = sb.instantiateViewController(withIdentifier: "NavSecond")
        
        if let vc = nav.childViewControllers.first as? SecondViewController {
            vc.bodyTitle = param
        }
        
        flutterVC.present(nav, animated: true, completion: nil)
    }
    
    private func openAlert(param: String, result: @escaping FlutterResult) {
        let alert = UIAlertController(title: "Native Alert", message: param, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            result("Ok was pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            result("Cancel was pressed")
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        flutterVC.present(alert, animated: true, completion: nil)
    }
    
    private func callApi(url: String, result: @escaping FlutterResult) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: flutterVC.view)
        
        guard let fullUrl = "\(url)search_all_teams.php?l=English Premier League".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        Alamofire.request(fullUrl).responseJSON { (response) in
            hud.dismiss()
            
            if let data = response.result.value {
                let json = JSON(data)
                result(json["teams"].rawString())
            }
        }
    }
}
