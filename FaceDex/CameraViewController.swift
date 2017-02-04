//
//  CameraViewController.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit
import SwiftyCam

class CameraViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {

	var flipCameraButton: UIButton!
	var flashButton: UIButton!
	var captureButton: SwiftyRecordButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		cameraDelegate = self
		maximumVideoDuration = 10.0
		addButtons()
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
		let newVC = PeopleViewController(image: photo)
		self.present(newVC, animated: true, completion: nil)
	}

	func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
		print("Did Begin Recording")
		captureButton.growButton()
		UIView.animate(withDuration: 0.25, animations: {
			self.flashButton.alpha = 0.0
			self.flipCameraButton.alpha = 0.0
		})
	}

	func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
		print("Did finish Recording")
		captureButton.shrinkButton()
		UIView.animate(withDuration: 0.25, animations: {
			self.flashButton.alpha = 1.0
			self.flipCameraButton.alpha = 1.0
		})
	}

	func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
		let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
		focusView.center = point
		focusView.alpha = 0.0
		view.addSubview(focusView)

		UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
			focusView.alpha = 1.0
			focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
		}, completion: { (success) in
			UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
				focusView.alpha = 0.0
				focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
			}, completion: { (success) in
				focusView.removeFromSuperview()
			})
		})
	}

	func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
		print(zoom)
	}

	func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
		print(camera)
	}

	@objc private func cameraSwitchAction(_ sender: Any) {
		switchCamera()
	}

	@objc private func toggleFlashAction(_ sender: Any) {
		flashEnabled = !flashEnabled

		if flashEnabled == true {
			flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
		} else {
			flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
		}
	}

	private func addButtons() {
		captureButton = SwiftyRecordButton(frame: CGRect(x: view.frame.midX - 37.5, y: view.frame.height - 100.0, width: 75.0, height: 75.0))
		self.view.addSubview(captureButton)
		captureButton.delegate = self

		flipCameraButton = UIButton(frame: CGRect(x: (((view.frame.width / 2 - 37.5) / 2) - 15.0), y: view.frame.height - 74.0, width: 30.0, height: 23.0))
		flipCameraButton.setImage(#imageLiteral(resourceName: "flipCamera"), for: UIControlState())
		flipCameraButton.addTarget(self, action: #selector(cameraSwitchAction(_:)), for: .touchUpInside)
		self.view.addSubview(flipCameraButton)

		let test = CGFloat((view.frame.width - (view.frame.width / 2 + 37.5)) + ((view.frame.width / 2) - 37.5) - 9.0)

		flashButton = UIButton(frame: CGRect(x: test, y: view.frame.height - 77.5, width: 18.0, height: 30.0))
		flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
		flashButton.addTarget(self, action: #selector(toggleFlashAction(_:)), for: .touchUpInside)
		self.view.addSubview(flashButton)
	}
}


