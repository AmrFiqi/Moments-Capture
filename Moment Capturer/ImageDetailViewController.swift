//
//  ImageDetailViewController.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 10/02/2023.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet var selectedImage: UIImageView!
    
    var selectedItem: String?
    var viewTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelectedImageView()
        setupTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // MARK: - Class Functions
    private func setupTitle(){
        navigationItem.largeTitleDisplayMode = .never
        title = viewTitle
    }
    
    private func setupSelectedImageView() {
        if let imageToLoad = selectedItem {
            selectedImage.image = UIImage(contentsOfFile: imageToLoad)
        }
    }
}
