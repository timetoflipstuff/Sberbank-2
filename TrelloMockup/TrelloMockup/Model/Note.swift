import  UIKit

class Note: Codable {
    
    var name = ""
    var imgURL: String?
    var id = ""
    
    convenience init(name: String, imgURL: String?, id: String?) {
        self.init()
        self.name = name
        self.imgURL = imgURL
        self.id = id ?? UUID().uuidString
    }
}
