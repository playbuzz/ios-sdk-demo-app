//
//  ExtensionsUIView.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 28/11/2023.
//
import UIKit
///
///
///
internal extension UIView
{
    var ay_allSubviews: [UIView]
    {
        subviews + subviews.flatMap({ $0.ay_allSubviews })
    }
}
