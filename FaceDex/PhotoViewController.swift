//
//  PhotoViewController.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

	override var prefersStatusBarHidden: Bool {
		return true
	}

	private var backgroundImage: UIImage
	private var peopleTableView: UITableView!
	private var viewModel: FaceViewModel!

	init(image: UIImage) {
		let imageData = UIImagePNGRepresentation(image)
		self.backgroundImage = image
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
		view.addSubview(backgroundImageView)

		let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
		cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
		cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
		view.addSubview(cancelButton)

		let width = view.bounds.width
		let height = view.bounds.height
		peopleTableView = UITableView(frame: CGRect(x: 0, y: height - 120, width: width, height: 120))
		peopleTableView.delegate = self
		peopleTableView.dataSource = self
		peopleTableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
		view.addSubview(peopleTableView)
	}

	func cancel() {
		dismiss(animated: true, completion: nil)
	}

	func show(whoThisIs persons: [Person]) {
		// do stuff here
	}
}

extension PhotoViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
		cell.textLabel?.text = "\(indexPath.row)"
		return cell
	}
}


extension PhotoViewController: UITableViewDelegate {
	// touch events
}

extension PhotoViewController: FaceModelDelegate {
	func enrollResponse() {
		// stuff here
	}
	
	func recognizeResponse() {
		// stuff here
	}
	
	func errorResponse() {
		// moar stuff
	}
}
