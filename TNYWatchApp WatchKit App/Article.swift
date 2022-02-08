import WatchKit

class Article: NSObject {
    
    let name: String
    let url: String
    var pausedDuration: Float?
    
    class func allItems() -> [Article] {
        var article: [Article] = []
        
        guard let path = Bundle.main.path(forResource: "Article", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return article
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
            json.forEach({ (dict: [String: String]) in
                article.append(Article(name: dict["name"] ?? "", url: dict["url"] ?? "", pausedDuration: nil))
                
            })
        } catch let error as NSError {
            print(error)
        }
        
        return article
    }
    
    init(name: String, url: String, pausedDuration: Float?) {
        self.name = name
        self.url = url
        self.pausedDuration = pausedDuration
    }
    
//    convenience init(dictionary: [String: String]) {
//        let name = dictionary["name"]!
//        let url = dictionary["url"]!
//        self.init(name: name, url: url)
//    }
}
