//
//  UserCell.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit
import Nuke

final class UserCell: UITableViewCell {
    static let reuseIdentifier = String(describing: UserCell.self)
    static let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    @IBOutlet public weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    public func configure(with user: User) {
        DispatchQueue.main.async {
            self.nameLabel.text = "\(user.first_name) \(user.last_name)"
            self.emailLabel.text = user.email
        }
    }
}
