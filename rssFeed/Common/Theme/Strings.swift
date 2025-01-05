//
//  Strings.swift
//  rssFeed
//
//  Created by Toni Pavic on 07.12.2024..
//

struct Strings {
    static let empty = ""
    static let ok = "OK"
    static let close = "Close"
    
    struct FeedList {
        static let title = "Feed List"
        static let empty = "No RSS feed added yet."
        
        struct AddFeed {
            static let title = "Add Feed"
            static let placeholder = "Enter RSS feed URL"
        }
    }
    
    struct Favourites {
        static let title = "Favourites"
        static let empty = "You haven't added any favourites."
    }
    
    struct Settings {
        static let title = "Settings"
        static let notifications = "Notifications"
        static let linkExternal = "Open links externally"
        static let darkMode = "Dark mode"
    }
    
    struct Error {
        static let alertTitle = "Error"
        static let generalError = "Something went wrong."
        static let invalidUrl = "Invalid URL."
    }
}
