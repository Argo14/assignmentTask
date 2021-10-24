//
//  ViewController.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 17/10/21.
//

import UIKit

class SelfSizedTableView: UITableView {
//  var maxHeight: CGFloat = UIScreen.main.bounds.size.height
//
//  override func reloadData() {
//    super.reloadData()
//    self.invalidateIntrinsicContentSize()
//    self.layoutIfNeeded()
//  }
//
//  override var intrinsicContentSize: CGSize {
//    let height = min(contentSize.height, maxHeight)
//    return CGSize(width: contentSize.width, height: height)
//  }
    
    override var contentSize:CGSize {
           didSet {
               invalidateIntrinsicContentSize()
           }
       }

       override var intrinsicContentSize: CGSize {
           layoutIfNeeded()
           return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
       }
    
   
    
   
}
