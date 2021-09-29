//
//  ViewController.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import UIKit
import SDWebImage


class ViewController: UIViewController, StopRefreshDelegate, BackOnlineDelegate {
    
    

    @IBOutlet weak var candidateTableView: UITableView!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var offlineViewLabel: UILabel!
    @IBOutlet weak var offlineViewHeightContraint: NSLayoutConstraint!
    
    var candidateViewModel : CandidateViewModel!
    var data : [canidateSections] = []
    var tempDict : [CandidateData] = []
    var refreshControl = UIRefreshControl()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Candidates list"
        self.offlineView.alpha = 0
        self.offlineViewHeightContraint.constant = 0
        uiUpdate()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        candidateTableView.addSubview(refreshControl)
        candidateTableView.tableFooterView = UIView()
    }
    //refresh control
    @objc func refresh(sender:AnyObject) {
        self.data.removeAll()
        self.candidateTableView.isUserInteractionEnabled = false
        self.uiUpdate()
   }
    
    // setting up the view.
    func uiUpdate(){
        self.candidateViewModel = CandidateViewModel()
        self.candidateViewModel.delegate = self
        self.candidateViewModel.onlineDelegate = self
        self.candidateViewModel.bindCandidateViewModelToController = {
            self.updateDataSource()
        }
    }
  
    // for updating the datasource
    func updateDataSource(){
        
        for items in  self.candidateViewModel.canidateData.data{
            self.tempDict.append(CandidateData(firstName: items.firstName, lastName: items.lastName, gender: items.gender, profileImage: items.profileImage, age: items.age, jobData: items.jobData, educationData: items.educationData))
            
            let firstName = items.firstName ?? ""
            let lastName = items.lastName ?? ""
            
            self.data.append(canidateSections(title: firstName + " " + lastName,items : self.tempDict))
            tempDict.removeAll()
            
        }
        
        self.refreshControl.endRefreshing()
        self.candidateTableView.isUserInteractionEnabled = true
        self.candidateTableView.dataSource = self
        self.candidateTableView.delegate = self
        self.candidateTableView.reloadData()
    }
    
    //For hiding offlineview when online
    func backOnline() {
        self.offlineView.alpha = 0
    }
    
    //for stopping refresh as well as showing the offline view if the app is offline.
    func stopRefresh(_ errorResponse: String) {
       
        self.offlineView.alpha = 1
        self.offlineViewHeightContraint.constant = 36
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
            self.refreshControl.endRefreshing()
            self.candidateTableView.setContentOffset(CGPoint.zero, animated: true)
            self.candidateTableView.reloadData()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(data.count == 0){
       return 0
        }else{
            return data[section].collapsed ? 0 : data[section].items.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(data.count == 0){
            return nil
        }else{
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = data[section].title
        header.section = section
        header.delegate = self
        return header
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell
        let dict : CandidateData = data[indexPath.section].items[indexPath.row]
        let firstName = dict.firstName ?? ""
        let lastName = dict.lastName ?? ""
        cell.candidateName.text = firstName + " " + lastName
        cell.profileImage.sd_setImage(with: URL(string:  dict.profileImage! ), placeholderImage: UIImage(named: "placeholder.png"))  
        cell.candidateAge.text = "\(dict.age ?? 0)" + " " + "years old"
        cell.candidateGender.text = dict.gender ?? "Not mentioned"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : CandidateData = data[indexPath.section].items[indexPath.row]
        let view : SeeMoreViewController = self.storyboard?.instantiateViewController(withIdentifier: "seemore") as! SeeMoreViewController
        #if DEBUG
        print(dict)
        #endif
        view.moreDetailsArray = dict
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !data[section].collapsed
        // Toggle collapse
        data[section].collapsed = collapsed
        // Reload the whole section
         candidateTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
