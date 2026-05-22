import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
    override func sceneWillResignActive(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = window.bounds
        blurView.tag = 9999
        window.addSubview(blurView)
    }

    override func sceneDidBecomeActive(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              let blurView = window.viewWithTag(9999) else { return }
        
        blurView.removeFromSuperview()
    }
}
