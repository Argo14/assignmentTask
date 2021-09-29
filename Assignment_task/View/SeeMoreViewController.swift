//
//  SeeMoreViewController.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 28/09/21.
//

import UIKit

class SeeMoreViewController: UIViewController {
    
    
    @IBOutlet weak var seeMoreTableView: UITableView!
    
    var moreDetailsArray : CandidateData!
    var tempDict : [JobData] = []
    var data : [jobSections] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        seeMoreTableView.delegate = self
        seeMoreTableView.dataSource = self
        updateUI()
        seeMoreTableView.tableFooterView = UIView()
    }
    // Set up UI and datasource.
    func updateUI(){
        for items in moreDetailsArray.jobData{
            self.tempDict.append(JobData(role: items.role, organization: items.organization, exp: items.exp))
        }
        self.data.append(jobSections(title: "Experience", items: self.tempDict))
        self.tempDict.removeAll()
        
        for items in moreDetailsArray.educationData{
            self.tempDict.append(JobData(role: items.degree, organization: items.institution, exp: 0))
        }
        self.data.append(jobSections(title: "Education", items: self.tempDict))
        self.tempDict.removeAll()
        self.seeMoreTableView.reloadData()
    }
 
}

extension SeeMoreViewController : UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
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
        let cell : ExperienceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ExperienceTableViewCell
        
        let dict : JobData = data[indexPath.section].items[indexPath.row]
        cell.roleLabel.text = dict.role
        cell.organizationLabel.text = dict.organization
        if dict.exp == 0{
            cell.experienceLabel.isHidden = true
        }else{
            cell.experienceLabel.isHidden = false
            cell.experienceLabel.text = "\(dict.exp ?? 0)" + " " + "years of experience"
        }

        return cell
        
    }
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !data[section].collapsed
        
        // Toggle collapse
        data[section].collapsed = collapsed

        // Reload the whole section
         seeMoreTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    
}
