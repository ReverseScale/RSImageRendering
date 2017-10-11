//
//  ViewController.swift
//  RSImageRenderingDemo
//
//  Created by WhatsXie on 2017/10/11.
//  Copyright © 2017年 WhatsXie. All rights reserved.
//

import UIKit

let redR = UIColor.red
let yellowR = UIColor.yellow
let blueR = UIColor.blue
let greenR = UIColor.green

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewOriginal: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func renderingWithRedCilck(_ sender: Any) {
        imageViewOriginal.image = renderingColorWithColor(color: redR, imageURL: "icon_grid_server")
    }
    @IBAction func renderingWithYellowCilck(_ sender: Any) {
        imageViewOriginal.image = renderingColorWithColor(color: yellowR, imageURL: "icon_grid_server")
    }
    @IBAction func renderingWithBlueCilck(_ sender: Any) {
        imageViewOriginal.image = renderingColorWithColor(color: blueR, imageURL: "icon_grid_server")
    }
    @IBAction func renderingWithGreenCilck(_ sender: Any) {
        imageViewOriginal.image = renderingColorWithColor(color: greenR, imageURL: "icon_grid_server")
    }
    
    func renderingColorWithColor(color:UIColor,imageURL:String) -> UIImage{
        let tintImage =  UIImage.init(named: imageURL)
        let renderedImage = tintImage?.imageWithTintColor(color: color, keepAlpha: true, keepGray: true)
        return renderedImage!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/**
 *  图片填充颜色
 *  保留alpha通道,即保留透明度和颜色灰度
 *
 *  @param tintColor
 *  @param keepAlpha:保留透明度
 *  @param keepGray:保留灰度
 *
 *  @returnnn
 */
extension UIImage{
    func imageWithTintColor(color:UIColor,keepAlpha:Bool,keepGray:Bool)->UIImage{
        //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        color.setFill()
        let bounds = CGRect(x:0, y:0, width:self.size.width, height:self.size.height)
        UIRectFill(bounds)
        if keepGray {
            //kCGBlendModeOverlay保留灰度
            self.draw(in: bounds, blendMode: .overlay, alpha: 1.0)
        }
        if keepAlpha {
            //则再用kCGBlendModeDestinationIn画一次,保留透明度
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }
        let tintImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintImage!
    }
}
