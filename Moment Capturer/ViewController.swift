//
//  ViewController.swift
//  Moment Capturer
//
//  Created by Amr El-Fiqi on 08/02/2023.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var moments = [Moment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PersonCell else{
            fatalError("Fatal error")
        }
        let thisMoment = moments[indexPath.row]
        cell.captioned.text = thisMoment.name
        print(thisMoment.name)
        
        let path = getDocumentsDirectory().appendingPathComponent(thisMoment.image)
        cell.imageViewer.image = UIImage(contentsOfFile: path.path)
        print(thisMoment.image)
        print(path)
        return cell
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else{return}
        selectedImage = image
        let imageName = UUID().uuidString
        print (imageName)
        print("hello")
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 1){
            try? jpegData.write(to: imagePath)
        }
        let moment = Moment(name: "Unknown", image: imageName)
        moments.append(moment)
        
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    @objc func addNewPerson(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
 
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
}

