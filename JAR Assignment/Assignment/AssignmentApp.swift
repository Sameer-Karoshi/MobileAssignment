//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import UIKit
// Step 1: Create the ContentViewControllerRepresentable
struct ContentViewControllerRepresentable: UIViewControllerRepresentable {
    let title: String
    
    func makeUIViewController(context: Context) -> UINavigationController {
        // Create an instance of ContentViewController
        let contentViewController = ContentViewController()
        
        // Set the title for the navigation item
        contentViewController.navigationItem.title = title
        
        // Wrap ContentViewController inside UINavigationController
        let navigationController = UINavigationController(rootViewController: contentViewController)
        
        // Make sure the navigation bar is visible
        navigationController.isNavigationBarHidden = false
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // You can update the navigation controller here if needed
    }
}

// Step 2: Define your SwiftUI App
@main
struct AssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            // Step 3: Use the ContentViewControllerRepresentable inside a NavigationView
            ContentViewControllerRepresentable(title: "Computers List")
        }
    }
}






