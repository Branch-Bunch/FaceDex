//
//  ProfileCell.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

	var name: String?
	var socialHandle: String?
	var profile: UIImage?

	private let nameLabel = UILabel()
	private let socialLabel = UILabel()
	private let profileView = UIImageView()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = UIColor.clear
		backgroundColor = UIColor.clear

		nameLabel.textAlignment = .left
		nameLabel.textColor = UIColor.darkText

		socialLabel.textAlignment = .left
		socialLabel.textColor = UIColor.darkText // TODO: make nice blue

		let blurEffect = UIBlurEffect(style: .light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.layer.cornerRadius = 10
		blurEffectView.layer.masksToBounds = true
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(blurEffectView)

		let verticalStackView = UIStackView(arrangedSubviews: [
			nameLabel,
			socialLabel
			])
		verticalStackView.axis = .vertical

		let horizontalStackView = UIStackView(arrangedSubviews: [
			profileView,
			verticalStackView
			])
		horizontalStackView.axis = .horizontal
		horizontalStackView.alignment = .leading

		horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(horizontalStackView)

		NSLayoutConstraint.activate([
			blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

			horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func render() {
		if let name = name {
			nameLabel.text = name
		}
		if let socialHandle = socialHandle {
			socialLabel.text = socialHandle
		}
		if let profile = profile {
			profileView.image = profile
		}
	}

	override func prepareForReuse() {
		name = nil
		socialHandle = nil
		profile = nil
		nameLabel.text = nil
		socialLabel.text = nil
		profileView.image = nil
	}
}

