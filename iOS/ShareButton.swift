//
//  ShareButton.swift
//  Counter
//
//  Created by Sebastiaan on 07/08/2020.
//

import SwiftUI

struct ShareButton: View {
    let activityItems: [Any]
    let excludedActivityTypes: [UIActivity.ActivityType]? = [.postToFacebook]
    
    let customActivity1 = ExampleActivity(title: "Example Activity 1", image: UIImage(systemName: "circle"), performAction: { sharedItems in
        guard let sharedStrings = sharedItems as? [String] else { return }

        for string in sharedStrings {
            print("Here's the string: \(string)")
        }
    })
    let customActivity2 = ExampleActivity(title: "Example Activity 2", image: UIImage(systemName: "circle.fill"), performAction: { sharedItems in
        guard let sharedStrings = sharedItems as? [String] else { return }

        for string in sharedStrings {
            print("Here's the string: \(string)")
        }
    })
    
    var body: some View {
        Button(action: {
            shareSheet()
        }) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    func shareSheet() {
        let activityView = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: [customActivity1, customActivity2]
        )
        activityView.excludedActivityTypes = [
            .postToFacebook
        ]
        activityView.completionWithItemsHandler = nil
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            activityView.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
//            activityView.popoverPresentationController?.sourceRect = CGRect(
//                x: UIScreen.main.bounds.width / 2.1,
//                y: UIScreen.main.bounds.height / 2.3,
//                width: 200, height: 200)
//        }
    }
}

class ExampleActivity: UIActivity {
    var _activityTitle: String
    var _activityImage: UIImage?
    var activityItems = [Any]()
    var action: ([Any]) -> Void
    
    init(title: String, image: UIImage?, performAction: @escaping ([Any]) -> Void) {
        _activityTitle = title
        _activityImage = image
        action = performAction
        super.init()
    }
    
    override var activityTitle: String? {
        return _activityTitle
    }
    
    override var activityImage: UIImage? {
        return _activityImage
    }
    
    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType(rawValue: "com.yoursite.yourapp.activity")
    }
    
    override class var activityCategory: UIActivity.Category {
        return .action
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        self.activityItems = activityItems
    }
    
    override func perform() {
        action(activityItems)
        activityDidFinish(true)
    }
}
