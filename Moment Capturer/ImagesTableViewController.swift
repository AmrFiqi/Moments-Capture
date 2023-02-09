//
//  ViewController.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 08/02/2023.
//

import UIKit

class ImagesTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    private var moments = [Moment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNAvigationItem()
    }
    
    // MARK: - Class Methods.
    
    private func setupNAvigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
    }
    
    @objc func addNewImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - Table View Delegate Methods.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let momentCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MomentCell else { return UITableViewCell() }
        
        let selectedMoment = moments[indexPath.row]
        
        let path = getDocumentsDirectory().appendingPathComponent(selectedMoment.image).path
        momentCell.setupCell(withModel: selectedMoment, imagePath: path)
        
        return momentCell
        
    }
}

// MARK: - Extension.

extension ImagesTableViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 1) {
            try? jpegData.write(to: imagePath)
        }
        
        let moment = Moment(name: "Unknown", image: imageName)
        moments.append(moment)
        tableView.reloadData()
        dismiss(animated: true)
    }
}
