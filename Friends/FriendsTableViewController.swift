//
//  FriendsTableViewController.swift
//  Friends
//
//  Created by Nivardo Ibarra on 12/28/15.
//  Copyright © 2015 Nivardo Ibarra. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    lazy var serviceData = NSMutableData()
    var friends: [Friend]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        if friends ==  nil {
            requestFriends()
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (friends == nil) ? 0 : friends!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)

        // Configure the cell...
        let friend = friends![indexPath.row]
        cell.textLabel?.text = friend.fullName
        cell.detailTextLabel?.text = "@\(friend.twitter!)"
        
        if friend.gender == Gender.Female {
            cell.backgroundColor = UIColor(red: 0.99, green: 0.3, blue: 0.52, alpha: 1)
        }else {
            cell.backgroundColor = UIColor(red: 0.82, green: 0.93, blue: 0.98, alpha: 1)
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func requestFriends() {
        let session = NSURLSession.sharedSession()
        let urlWebService = "http://gzfrancisco.name/resources/friends.json"
        let url = NSURL(string: urlWebService)
        
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
//                self.parsingHelper.parseData(isbnBook, data: data!);
                self.serviceData.appendData(data!)
                self.parseData(data!)
            }
        }
        task.resume()
    }

    func parseData(data: NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
            friends = Friend.fromDictionary(json)
//            print(friends)
            tableView.reloadData()
        }catch {
            abort()
        }
    }
}
