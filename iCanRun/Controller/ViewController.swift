//
//  ViewController.swift
//  iCanRun
//
//  Created by Eric Torigian on 4/17/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalRuns: UILabel!
    @IBOutlet weak var bestRunPace: UILabel!
    @IBOutlet weak var bestRunDate: UILabel!
    
    var runs = [Runs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let db = Firestore.firestore()
    
        db.collection("runs")
        
        db.collection("runs").order(by: "date").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("error \(String(describing: error?.localizedDescription))")
            } else {
                self.runs.removeAll()
                
                for document in (snapshot?.documents)! {
                    let newRun = Runs(name: document.data()["name"] as! String,
                                      date: document.data()["date"] as! String,
                                      time: document.data()["time"] as! String,
                                      distance: document.data()["distance"] as! String,
                                      pace: document.data()["pace"] as! String,
                                      mood: document.data()["mood"] as! String
                    )
                    
                    self.runs.append(newRun)
                }
                
                self.tableView.reloadData()
                self.totalRuns.text = String(self.runs.count)
            }
            
            db.collection("runs").order(by: "pace").limit(to: 1).getDocuments(completion: { (snapshot, error) in
                if error == nil {
                
                    for document in (snapshot?.documents)! {
                        let bestRun = Runs(name: document.data()["name"] as! String,
                                       date: document.data()["date"] as! String,
                                       time: document.data()["time"] as! String,
                                       distance: document.data()["distance"] as! String,
                                       pace: document.data()["pace"] as! String,
                                       mood: document.data()["mood"] as! String )
                        
                        self.bestRunDate.text = bestRun.date
                        self.bestRunPace.text = bestRun.pace
                        
                        }
                    
    
                }
                
                
            })
        
            
        }
        
    
     
        
        
    }

        
    
    

    @IBAction func addRunButtonPressed(_ sender: Any) {
        //send data to firestore
        let runCollection = Firestore.firestore().collection("runs")
        
        let run = Runs(
            name: "test run",
            date: "20180417",
            time: "30",
            distance: "2 mile",
            pace: "15:00",
            mood: "Tired"
        )
        
        runCollection.addDocument(data: run.dictionary )
        
    }
    
    //MARK - tableview functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "runDataCell")
        
        cell?.textLabel?.text = runs[indexPath.row].name
        cell?.detailTextLabel?.text = runs[indexPath.row].date
        
        return cell!
    }
    
    
}

