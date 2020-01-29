//
//  DetailUserViewController.swift
//  ProgrammaticUserCells
//
//  Created by Lilia Yudina on 1/29/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit
import ImageKit

class DetailUserViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let user = user else {
              fatalError("did not load a podcast from segue")
          }
        nameLabel.text = ("\(user.name.title) \(user.name.first) \(user.name.last)")
        emailLabel.text = ("Email: \(user.email)")
        phoneLabel.text = ("Phone: \(user.phone)")
        
        userImage.getImage(with: user.picture.large) { [weak self] (result) in
              switch result {
              case .failure:
              break
              case .success(let image):
                  DispatchQueue.main.async {
                      self?.userImage.image = image
                  }
              }
          }
    }
    
}
