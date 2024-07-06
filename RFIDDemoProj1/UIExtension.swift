
import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadius : CGFloat {
        get{
            return self.layer.cornerRadius
        }
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set(newValue) {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor : UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set(newValue) {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var offsetShadow : CGSize {
        get {
            return self.layer.shadowOffset
        }
        set(newValue) {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity : Float {
        get{
            return self.layer.shadowOpacity
        }
        set(newValue) {
            self.layer.shadowOpacity = newValue
        }
        
    }
    
    @IBInspectable
    var shadowColor : UIColor? {
        get{
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set(newValue) {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var maskToBounds : Bool {
        get {
            return self.layer.masksToBounds
        }
        set(newValue) {
            self.layer.masksToBounds = newValue
        }
    }
}

extension UITextField {
    @IBInspectable
    var placeholderColor: UIColor? {
        get {
            // Retrieve the current placeholder color
            let attributedString = self.attributedPlaceholder
            var range = NSRange(location: 0, length: attributedString?.length ?? 0)
            let attributes = attributedString?.attributes(at: 0, effectiveRange: &range)
            return attributes?[.foregroundColor] as? UIColor
        }
        set {
            // Set the placeholder color
            guard let placeholder = self.placeholder else { return }
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: newValue ?? UIColor.placeholderText])
        }
    }
}

extension UIViewController {
    
    var activityIndicatorHoldingViewTag: Int { return 999999 }
    
    func startActivityIndicator() {
        DispatchQueue.main.async {
            //create holding view
            let holdingView = UIView(frame: UIScreen.main.bounds)
            holdingView.backgroundColor = .black
            holdingView.alpha = 0.45
            
            //Add the tag so we can find the view in order to remove it later
            holdingView.tag = self.activityIndicatorHoldingViewTag
            
            //create activity indicator
            let activityIndicator = UIActivityIndicatorView(style: .large)
             activityIndicator.center = self.view.center
             activityIndicator.hidesWhenStopped = true
             activityIndicator.color = UIColor.link
             //Start animating and add the view
             activityIndicator.startAnimating()

            holdingView.addSubview(activityIndicator)
            self.view.addSubview(holdingView)
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async{
            //Here we find the `UIActivityIndicatorView` and remove it from the view
            if let holdingView = self.view.subviews.filter({ $0.tag == self.activityIndicatorHoldingViewTag}).first {
                holdingView.removeFromSuperview()
            }
        }
    }

}
