import UIKit

class UINote {
    
    var name = ""
    var img: UIImage = UIImage(named: "note")!
    
    convenience init(name: String, img: UIImage?) {
        self.init()
        self.name = name
        self.img = img ?? UIImage(named: "note")!
    }
    
    convenience init(_ note: Note){
        self.init()
        self.name = note.name
        self.img = UIImage(named: "note")!
        
    }
}
