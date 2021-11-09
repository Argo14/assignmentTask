//
//  TableViewCell.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import UIKit
import SDWebImage

protocol UpdateTableView {
    func updateTableViewHeight()
}

class TableViewCell: UITableViewCell{

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var candidateName: UILabel!
    
    @IBOutlet weak var candidateAge: UILabel!
    
    @IBOutlet weak var candidateGender: UILabel!
    
    @IBOutlet weak var experienceTableView: UITableView!
    
    var moreDetailsArray : CandidateData!
    var tempDict : [JobData] = []
    var data : [jobSections] = []
    var delegate : UpdateTableView!
    var dataCount : Int!
    var candidateViewModel : CandidateViewModel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        experienceTableView.estimatedRowHeight = 100
        experienceTableView.rowHeight = UITableView.automaticDimension
      
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        
     }
    
    func updateUI(){
            self.experienceTableView.delegate = self
            self.experienceTableView.dataSource = self
            if #available(iOS 15.0, *) {
                experienceTableView.sectionHeaderTopPadding = 0
            }
            self.experienceTableView.reloadData()

    }
}

//MARK:- Table view delegate and datasource

extension TableViewCell : UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate {
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
    
    // This delegate function is to expand and collapse a particular section.
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !data[section].collapsed
        // Toggle collapse
        data[section].collapsed = collapsed
        // Reload the whole section
        
         experienceTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        self.delegate.updateTableViewHeight()
    }
}

