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
    static let options = ImageLoadingOptions(placeholder: UIImage(named: "loading"), transition: .fadeIn(duration: 0.33), failureImage: UIImage(named: "notfound"), failureImageTransition: .fadeIn(duration: 0.33))
    
    @IBOutlet public weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    public func configure(with user: User) {
        self.nameLabel.text = "\(user.first_name) \(user.last_name)"
        self.emailLabel.text = user.email
        if let imageUrl = user.avatarUrl {
            Nuke.loadImage(with: imageUrl, options: UserCell.options, into: self.avatarImageView)
        } else {
            Nuke.cancelRequest(for: self.avatarImageView)
            self.avatarImageView.image = UIImage(named: "placeholder")
        }
    }
}
