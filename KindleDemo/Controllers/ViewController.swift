//
//  ViewController.swift
//  KindlDemo
//
//  Created by Findl on 5/9/19.
//  Copyright © 2019 YD. All rights reserved.
//

import UIKit



class ViewController: UITableViewController {

    var books: [Book]?
    let cellId = "cellId"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyles()
        
        navigationItem.title = "Kindle"
        
        tableView.register(BookCell.self, forCellReuseIdentifier: cellId)
        
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        tableView.tableFooterView = UIView()
        
        //setupBooks()
        fetchBooks()
        
    }

    
    
    func setupNavigationBarStyles() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    
    func setupNavBarButtons() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPressed))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonPress))
        
    }
    
    
    @objc func handleMenuPressed() {
        
        print("Menu pressed")
        
    }
    
    
    @objc func handleAmazonPress() {
        
        print("Menu pressed")
        
    }
    
  /*  func setupBooks() {
        
        let page1 = Page(number: 1, text: "Text for first page")
        let page2 = Page(number: 2, text: "Text for second page")
        
        let pages = [page1, page2]
        
       // let book = Book(title: "Steve Jobs", author: "Walter Isaacson", image: UIImage(named: "SJ")!, page: pages)
        
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michal Becraft", image: UIImage(named: "BG")!, page: [
            Page(number: 1, text: "Text for page 1"),
            Page(number: 2, text: "Text for page 2"),
            Page(number: 2, text: "Text for page 3"),
            Page(number: 2, text: "Text for page 4")
            ])
        
        
        //self.books = [book, book2]
        
    }*/
    
    
    func fetchBooks() {
        
        let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json")
        URLSession.shared.dataTask(with: url!) { (data
            , response, error) in
            
            if let err = error {
                print("Failed to fetch external JSon books: ", err)
                return
            }
            
            guard let data = data else {return}
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                guard let bookDictionnaries = json as? [[String: Any]] else {return}
                
                
                self.books = []
                for  bookDictionnary in bookDictionnaries {
                    
                    let book = Book(dictionary: bookDictionnary)
                    self.books?.append(book)
                    
                    DispatchQueue.main.async {
                          self.tableView.reloadData()
                    }
                }
            } catch let jsonError {
                
                print("Failed to parse JSON proporly: ", jsonError)
                
            }
            
        }.resume()
        
    }
    
    //TODO: TableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let count = books?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
        
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        bookPageController.book = selectedBook
        let navController = UINavigationController(rootViewController: bookPageController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(segmentedControl)
        
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        return footerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}

