
import UIKit

class UINote {
    
    var name = ""
    var img: UIImage?
    
    convenience init(name: String, img: UIImage?) {
        self.init()
        self.name = name
        self.img = img ?? UIImage(named: "notes")
    }
    
    convenience init(_ note: Note){
        self.init()
        self.name = note.name
        self.img = UIImage(named: "notes")
        
    }
}
