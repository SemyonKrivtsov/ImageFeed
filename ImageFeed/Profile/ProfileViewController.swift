//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Семён Кривцов on 18.05.2024.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var logoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func didTapLogoutButton(_ sender: Any) {
    }
}
