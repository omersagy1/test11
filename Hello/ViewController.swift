//
//  ViewController.swift
//  Hello
//
//  Created by Omer Sagy on 11/11/18.
//  Copyright © 2018 Omer Sagy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RgbLabel: UILabel!
    @IBOutlet weak var HexLabel: UILabel!
    @IBOutlet weak var RedLabel: UILabel!
    @IBOutlet weak var GreenLabel: UILabel!
    @IBOutlet weak var BlueLabel: UILabel!

    @IBOutlet weak var RgbValue: UILabel!
    @IBOutlet weak var HexValue: UILabel!

    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!

    @IBOutlet weak var resetButton: UIButton!

    var labels: [UILabel?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        labels = [
            RgbLabel,
            HexLabel,
            RedLabel,
            GreenLabel,
            BlueLabel,
        ]

        resetButton.addTarget(
            self,
            action: #selector(resetButtonTapped(_:)),
            for: .touchUpInside
        )

        render()
    }

    @IBAction func redChanged(_ sender: UISlider) {
        render()
    }

    @IBAction func greenChanged(_ sender: UISlider) {
        render()
    }

    @IBAction func blueChanged(_ sender: UISlider) {
        render()
    }

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        RedSlider.setValue(0.5, animated: true)
        GreenSlider.setValue(0.5, animated: true)
        BlueSlider.setValue(0.5, animated: true)
        render()
    }

    var red: Float {
        return RedSlider.value
    }

    var green: Float {
        return GreenSlider.value
    }

    var blue: Float {
        return BlueSlider.value
    }

    func render() {
        let bgColor = UIColor(
            displayP3Red: CGFloat(self.red),
            green: CGFloat(self.green),
            blue: CGFloat(self.blue),
            alpha: 1.0)
        self.view.backgroundColor = bgColor

        let tc: UIColor = textColor()

        for label in labels {
            label?.textColor = tc
        }

        RgbValue.textColor = tc
        HexValue.textColor = tc

        RgbValue.text = rgbValue()
        HexValue.text = hexValue()
    }

    func textColor() -> UIColor {
        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
        return luminance > 0.5 ? .black : .white
    }

    func rgbValue() -> String {
        let r = String(format: FormatConstant.DECIMAL,
                       arguments: [self.red * 255.0])
        let g = String(format: FormatConstant.DECIMAL,
                       arguments: [self.green * 255.0])
        let b = String(format: FormatConstant.DECIMAL,
                       arguments: [self.blue * 255.0])
        return "\(r), \(g), \(b)"
    }

    func hexValue() -> String {
        let redInt = Int((self.red * 255.0).rounded())
        let r = String(
            format: FormatConstant.HEX,
            arguments: [redInt])

        let greenInt = Int((self.green * 255.0).rounded())
        let g = String(
            format: FormatConstant.HEX,
            arguments: [greenInt])

        let blueInt = Int((self.blue * 255.0).rounded())
        let b = String(format: FormatConstant.HEX,
                       arguments: [blueInt])
        return "#\(r)\(g)\(b)"
    }

}


