//
//  PeopleViewController.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

	override var prefersStatusBarHidden: Bool {
		return true
	}

	private var backgroundImage: UIImage
	fileprivate var peopleTableView: UITableView!
	fileprivate var viewModel: FaceViewModel!
	fileprivate var fetched: Bool

	init(image: UIImage) {
		let imageData = UIImagePNGRepresentation(image)
		self.backgroundImage = image
		fetched = false
		super.init(nibName: nil, bundle: nil)
		viewModel = FaceViewModel(imageData: imageData)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.gray

		let backgroundImageView = UIImageView(frame: view.frame)
		backgroundImageView.image = backgroundImage

		let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
		cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
		cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)

		peopleTableView = UITableView(frame: view.bounds)
		peopleTableView.backgroundColor = .clear
		peopleTableView.contentInset = UIEdgeInsets(top: view.bounds.height - 64, left: 0, bottom: 0, right: 0)
		peopleTableView.rowHeight = 64
		peopleTableView.separatorStyle = .none
		peopleTableView.delegate = self
		peopleTableView.dataSource = self
		peopleTableView.register(TextCell.self, forCellReuseIdentifier: String(describing: TextCell.self))
		peopleTableView.register(ProfileCell.self, forCellReuseIdentifier: String(describing: ProfileCell.self))

		view.addSubview(backgroundImageView)
		view.addSubview(peopleTableView)
		view.addSubview(cancelButton)

		viewModel.delegate = self
		viewModel.recognizeFace()
	}

	func cancel() {
		fetched = false
		dismiss(animated: true, completion: nil)
	}
}

extension PeopleViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (fetched) ? viewModel.persons.count + 1 : 0 // extra 1 for question cell
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let masterCell: UITableViewCell
		if indexPath.row == viewModel.persons.count {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextCell.self)) as! TextCell
			cell.title = "Want to capture this person?"
			cell.render()
			masterCell = cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileCell.self)) as! ProfileCell
			let person = viewModel.persons[indexPath.row]
			cell.name = person.name
			cell.socialHandle = person.github.handle
			if let data = viewModel.profiles[indexPath.row], let image = UIImage(data: data) {
				cell.profile = image
			}
			cell.render()
			masterCell = cell
		}
		return masterCell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return indexPath.row == viewModel.persons.count ? 64 : 90
	}
}

extension PeopleViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == viewModel.persons.count {
			let alert = UIAlertController(title: "Capture this person!", message: nil, preferredStyle: .alert)
			alert.addAction(
				UIAlertAction(title: "Capture", style: .default, handler: { [weak self] (action: UIAlertAction) in
					guard let nameField = alert.textFields?.first, nameField.text != nil, let name = nameField.text, !name.isEmpty, let githubField = alert.textFields?.last, githubField.text != nil, let github = githubField.text, !github.isEmpty else { return }
					
					self?.viewModel.enrollFace(name: name, handle: github)
			}))
			alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
			alert.addTextField {(textField: UITextField!) in
				textField.placeholder = "Name"
			}
			alert.addTextField {(textField: UITextField!) in
				textField.placeholder = "Github"
			}
			present(alert, animated: true, completion: nil)
		} else {
			let url = viewModel.persons[indexPath.row].github.url
			UIApplication.shared.open(NSURL(string: url) as! URL, options: [:], completionHandler: nil)
		}
	}
}

extension PeopleViewController: FaceModelDelegate {
	func enrollResponse(enrollResponse: EnrollResponse) {
		if enrollResponse.success {
			dismiss(animated: true, completion: nil)
		} else {
			let alert = UIAlertController(title: "Error", message: enrollResponse.error, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Dissmiss", style: .destructive, handler: nil))
			present(alert, animated: true, completion: nil)
		}
	}

	func recognizeResponse() {
		fetched = true
		peopleTableView.reloadData()
	}

	func updatedImageAt(index: Int) {
		let indexPath = IndexPath(row: index, section: 0)
		peopleTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
	}

	func errorResponse(message: String) {
		fetched = true
		peopleTableView.reloadData()
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
		present(alert, animated: true, completion: nil)
	}

}
