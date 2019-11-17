
import UIKit

class UINote {
    
    var name = ""
    var img: UIImage?
    
    convenience init(name: String, img: UIImage?) {
        self.init()
        self.name = name
        self.img = img
    }
}
