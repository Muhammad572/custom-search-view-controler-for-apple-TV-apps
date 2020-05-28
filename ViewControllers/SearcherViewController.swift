//
//  SearcherViewController.swift
//  Karaoketv
//
//  Created by Wajih Invotyx on 28/05/2020.
//  Copyright © 2020 ZeeshanFayyaz. All rights reserved.
//
var objsearcher = SearcherViewController()
import UIKit

class SearcherViewController: UIViewController {

    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        objsearcher = self
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationsearchTable") as! SearchVideosViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for videos"
        searchBar.layer.masksToBounds = true
        searchBar.backgroundColor =  UIColor.clear
        resultSearchController!.view.backgroundColor =  UIColor.clear
        resultSearchController!.searchBar.keyboardAppearance = UIKeyboardAppearance.dark
        resultSearchController!.searchBar.backgroundColor = UIColor.clear

        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        //Here is where I set the color of the search bar text.
//        resultSearchController!.searchBar

        //Here is where I attempt to remove any possible color changes
        //or effect... none of the following 2 lines work
        resultSearchController!.searchBar.tintColor = .lightGray
        resultSearchController!.searchBar.barTintColor = .white
        
        resultSearchController!.hidesNavigationBarDuringPresentation = false
        resultSearchController!.obscuresBackgroundDuringPresentation = true
        resultSearchController!.searchBar.searchBarStyle = .minimal
        navigationItem.titleView = resultSearchController?.searchBar
    }
    
     override var preferredFocusedView: UIView? {
        resultSearchController?.searchBar.becomeFirstResponder()
        return resultSearchController!.searchBar
     }

}


