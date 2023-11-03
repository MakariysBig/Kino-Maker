//
//  AnimateButton.swift
//  KinoMaker
//
//  Created by Maksim Makarevich on 3.11.23.
//


import SnapKit
import UIKit

// MARK: - PhoneNumberTextField

final class AnimateButton: UIButton {

    var isDisabled = true {
        didSet {
            if isDisabled {
                backgroundColor = .lightGray
//                layer.borderColor = R.color.darkGrey()?.cgColor
                setTitleColor(.darkGray, for: .normal)
                isEnabled = false
            } else {
                backgroundColor = .systemBlue
//                layer.borderColor = UIColor.clear.cgColor
                setTitleColor(.white, for: .normal)
                isEnabled = true
            }
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupButton()
    }

    private func setupButton() {
//        titleLabel?.font = R.font.sfProDisplayBold(size: 16)
//        layer.cornerRadius = LayerConstants.cornerRadius8
        layer.cornerRadius = 8
//        layer.borderWidth = LayerConstants.borderWidth
        self.subviews.first?.gestureRecognizers?.forEach { recognizer in
            recognizer.cancelsTouchesInView = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.alpha = 0.6
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.alpha = 1
    }

}
