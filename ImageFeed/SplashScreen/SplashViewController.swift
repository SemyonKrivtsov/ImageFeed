//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Семён Кривцов on 10.06.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Private properties
    private let storage = OAuth2TokenStorage()
    private let showAuthenticationScreenSegueIdentifier =
    "showAuthenticationScreen"
    private let tabBarControllerID = "TabBarViewController"
    
    // MARK: - Life cyrcle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let authToken = storage.authToken {
            print("Auth token in cache: \(authToken)")
            switchToTabBarController()
        } else {
            performSegue(withIdentifier: showAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Override methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(showAuthenticationScreenSegueIdentifier)")
                return
            }
            viewController.delegate = self
            
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Private methods
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: tabBarControllerID)
        window.rootViewController = tabBarController
    }
}

// MARK: - AuthViewControllerDelegate
extension SplashViewController: AuthViewControllerDelegate {
    func didAuthenticate(_ vc: AuthViewController) {
        vc.navigationController?.popViewController(animated: true)
        dismiss(animated: true)
        switchToTabBarController()
    }
}
