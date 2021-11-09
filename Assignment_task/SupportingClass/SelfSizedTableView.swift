//
//  ViewController.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 17/10/21.
//

//MARK:- To make the tables self sized based on the content.

import UIKit

class SelfSizedTableView: UITableView {
    
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
