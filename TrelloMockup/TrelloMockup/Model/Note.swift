class Note: Decodable {
    
    var name = ""
    var imgURL: String?
    
    convenience init(name: String, imgURL: String?) {
        self.init()
        self.name = name
        self.imgURL = imgURL
    }
}
