//
//  Spinner.swift
//  rssFeed
//
//  Created by Toni Pavic on 10.12.2024..
//

import UIKit

final class Spinner {
    static var spinnerView: UIActivityIndicatorView?
    
    static var style: UIActivityIndicatorView.Style = .large
    static var backgroundColor: UIColor = .clear
    static var color: UIColor = Colors.primary
    
    static func start(style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, color: UIColor = color) {
        if spinnerView == nil,
           let window = UIApplication.shared.connectedScenes
               .compactMap({ $0 as? UIWindowScene })
               .flatMap({ $0.windows })
               .first(where: { $0.isKeyWindow }) {
            
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.color = color
            spinnerView!.style = style
            window.addSubview(spinnerView!)
            spinnerView!.startAnimating()
        }
    }
    
    static func stop() {
        if let _ = spinnerView {
            spinnerView!.stopAnimating()
            spinnerView!.removeFromSuperview()
            spinnerView = nil
        }
    }
}
