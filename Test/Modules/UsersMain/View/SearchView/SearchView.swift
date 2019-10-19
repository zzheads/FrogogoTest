//
//  SearchView.swift
//  Test
//
//  Created by Алексей Папин on 19.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit

protocol SearchViewDataSource: class {
    func users(for searchText: String?) -> [User]
}

class SearchView: UIView {
    static let height: CGFloat = 52
    static let nibName = String(describing: SearchView.self)
    static let nib = UINib(nibName: nibName, bundle: nil)
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var isActive: Bool = false {
        didSet { self.stateDidChanged() }
    }
    public var stateHandler: ((Bool) -> Void)?
    public var maxHeight: CGFloat = UIScreen.main.bounds.height
    
    private var searchViewHeightConstraint: NSLayoutConstraint!
    public var dataSource: SearchViewDataSource? 
    
    class func instanceFromNib(searchViewHeightConstraint: NSLayoutConstraint) -> SearchView? {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? SearchView else {
            return nil
        }
        view.searchViewHeightConstraint = searchViewHeightConstraint
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(UserCell.nib, forCellReuseIdentifier: UserCell.reuseIdentifier)
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = UserCell.height
        self.tableView.keyboardDismissMode = .onDrag
        self.textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .allEditingEvents)
        self.textField.delegate = self
        self.button.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func textChanged(_ sender: UITextField) {
        self.reloadData()
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        self.isActive = !self.isActive
        if self.isActive {
            self.textField.becomeFirstResponder()
        } else {
            self.textField.text = nil
            self.textField.resignFirstResponder()
        }
    }
    
    private func stateDidChanged() {
        self.button.setImage(UIImage(named: self.isActive ? "close" : "search"), for: .normal)
        self.stateHandler?(self.isActive)
        self.reloadData()
    }
    
    public func reloadData() {
        self.tableView.reloadData()
        let height = min(self.maxHeight, SearchView.height + self.tableView.contentSize.height)
        self.searchViewHeightConstraint.constant = height
        self.superview?.layoutIfNeeded()
    }
}

extension SearchView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard self.isActive else { return 0 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.isActive else { return 0 }
        return self.dataSource?.users(for: self.textField.text).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as! UserCell
        if let user = self.dataSource?.users(for: self.textField.text)[indexPath.row] {
            cell.configure(with: user)
        }
        return cell
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !self.isActive { self.isActive = true }
    }
}
