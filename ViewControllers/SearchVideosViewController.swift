//
//  SearchVideosViewController.swift
//  StandUpComedyApp
//
//  Created by Wajih Invotyx on 22/05/2020.
//  Copyright © 2020 ZeeshanFayyaz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import XCDYouTubeKit
import SDWebImage
import ParallaxView

class SearchVideosViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var channelVediosCollectionView: UICollectionView!
    @IBOutlet var longPressGesture: UILongPressGestureRecognizer!
    @IBOutlet weak var txtsearch: UITextField!
    
    @IBOutlet var AddPopUp: UIView!
    @IBOutlet var RemovePopUp: UIView!
      
    let playerViewController = AVPlayerViewController()
      
    var arrChannelVedios = [ChannelVedios]()
    var tokenNum = ""
    var channel = channels()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.channelVediosCollectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        
        AddPopUp.frame = CGRect(x: 550, y: 470, width: 800, height: 300)
        view.addSubview(AddPopUp)
        AddPopUp.isHidden = true
        
        RemovePopUp.frame = CGRect(x: 500, y: 470, width: 800, height: 300)
        view.addSubview(RemovePopUp)
        RemovePopUp.isHidden = true
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        objsearcher.resultSearchController?.searchBar.becomeFirstResponder()
//    }
    
      func playerDidFinishPlaying(note: NSNotification) {
            print("Video Finished")
        }
        
    @IBAction func btnsearch(_ sender: UIButton) {
        if txtsearch.text == ""{
            return
        }
        self.GetPlayListVedios(word: txtsearch.text!)
    }
    //////////// UICollectionView???????????
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrChannelVedios.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelVedio", for: indexPath) as! ChannelVediosCollectionViewCell
            
            cell.cellImage.sd_setImage(with: URL(string: arrChannelVedios[indexPath.row].Thumnails), placeholderImage: UIImage(named: "placeholder.png"))
            cell.cellTitle.text = arrChannelVedios[indexPath.row].VedioTitle
            
            cell.CellViewShadow.layer.shadowColor = UIColor.darkGray.cgColor
            //cell.contentView.backgroundColor = UIColor.black
            cell.CellViewShadow.layer.shadowRadius = 35.0
            
            cell.CellViewShadow.layer.shadowOpacity = 10
            cell.CellViewShadow.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            cell.CellViewShadow.clipsToBounds = false
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            self.playVideo(videoIdentifier: arrChannelVedios[indexPath.row].VedioId)
        }
        
        func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
            UIView.animate(withDuration: 0.4) {
                if let cell = collectionView.cellForItem(at: indexPath) as? ChannelVediosCollectionViewCell {
                    cell.cellImage.transform = .init(scaleX: 0.95, y: 0.95)
                    cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
                }
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
            UIView.animate(withDuration: 0.4) {
                if let cell = collectionView.cellForItem(at: indexPath) as? ChannelVediosCollectionViewCell {
                    cell.cellImage.transform = .identity
                    cell.contentView.backgroundColor = .clear
                }
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
            
    //        if let previousIndexPath = context.previouslyFocusedIndexPath,
    //            let cell = collectionView.cellForItem(at: previousIndexPath) as? ChannelVediosCollectionViewCell {
    //
    //            cell.contentView.removeParallaxMotionEffects()
    //
    //            cell.cellImage.transform = CGAffineTransform.identity
    //            cell.CellViewShadow.transform = CGAffineTransform.identity
    //
    //            cell.cellTitle.textColor = UIColor.gray
    //
    //        }
            
            if let indexPath = context.nextFocusedIndexPath,
                let cell = collectionView.cellForItem(at: indexPath) as? ChannelVediosCollectionViewCell {
                
                for i in 0..<arrChannelVedios.count{
                    
                    let index = IndexPath(row: i, section: 0)
                    
                    if indexPath == index {
                        
                    }
                    else{
                        
                        let cell1 = collectionView.cellForItem(at: index) as? ChannelVediosCollectionViewCell
                        cell1?.contentView.removeParallaxMotionEffects()
                        cell1?.contentView.removeParallaxMotionEffects()
                        cell1?.cellImage.transform = CGAffineTransform.identity
                        cell1?.CellViewShadow.transform = CGAffineTransform.identity
                       // cell1?.lblCell.textColor = UIColor.gray
                        
                    }
                }
                
                cell.contentView.addParallaxMotionEffects()
                
                cell.cellImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                cell.CellViewShadow.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
                cell.cellTitle.textColor = UIColor.black

            }
            
            if ((context.nextFocusedIndexPath != nil) && !collectionView.isScrollEnabled) {
                
                if let aPath = context.nextFocusedIndexPath {
                    collectionView.scrollToItem(at: aPath, at: .centeredHorizontally, animated: true)
                }
            }
            
        }

        var indexx = IndexPath()
        
        @objc func handleLongPress(sender : UILongPressGestureRecognizer!) {
            if sender.state != .ended {
                return
            }
            
            let p = sender.location(in: self.channelVediosCollectionView)
            
            if let indexPath = self.channelVediosCollectionView.indexPathForItem(at: p) {
                // get the cell at indexPath (the one you long pressed)
                let cell = self.channelVediosCollectionView.cellForItem(at: indexPath) as! ChannelVediosCollectionViewCell
                if cell.fav{
                    channelVediosCollectionView.isUserInteractionEnabled = false
                    indexx = indexPath
                   
                 RemovePopUp.isHidden = false
    //                cell.fav = false
    //                cell.cellFavouriteImage.image = UIImage(named: "unfavourite")
                }else{
                     channelVediosCollectionView.isUserInteractionEnabled = false
                    indexx = indexPath
                    AddPopUp.isHidden = false
    //                cell.fav = true
    //                favouriteArray.append(arrChannelVedios[indexPath.row])
    //                Save()
    //                cell.cellFavouriteImage.image = UIImage(named: "favourite")
                }
                // do stuff with the cell
            } else {
                print("couldn't find index path")
            }
        }
    
       @IBAction func btnAddYes(_ sender: UIButton) {
           
          
                // get the cell at indexPath (the one you long pressed)
                let cell = self.channelVediosCollectionView.cellForItem(at: indexx) as! ChannelVediosCollectionViewCell
                if !cell.fav{
                    cell.fav = true
                    favouriteArray.append(arrChannelVedios[indexx.row])
                    Save()
                    cell.cellFavouriteImage.image = UIImage(named: "favourite")
                }
            AddPopUp.isHidden = true
             channelVediosCollectionView.isUserInteractionEnabled = true
        }
        
        @IBAction func btnAddNo(_ sender: UIButton) {
            
            AddPopUp.isHidden = true
             channelVediosCollectionView.isUserInteractionEnabled = true
        }
        
        @IBAction func btnRemoveYes(_ sender: UIButton) {
            
            let cell = self.channelVediosCollectionView.cellForItem(at: indexx) as! ChannelVediosCollectionViewCell
            if cell.fav{
                    cell.fav = false
                    cell.cellFavouriteImage.image = UIImage(named: "unfavourite")
                var count = 0
                for i in favouriteArray{
                    if i.ChannelId == arrChannelVedios[indexx.row].ChannelId {
                        if favouriteArray[count].ChannelId != " " {
                            favouriteArray.remove(at: count)
                            Save()
                        }
                        else{
                          //  return
                        }
                    }
                    else{
                    count = count+1
                       // return
                    }
                }
                        }
            RemovePopUp.isHidden = true
             channelVediosCollectionView.isUserInteractionEnabled = true
            
        }
        @IBAction func btnRemoveNo(_ sender: UIButton) {
            RemovePopUp.isHidden = true
             channelVediosCollectionView.isUserInteractionEnabled = true
            
        }
        
        
        //////////////////////// Play Youtube Vedio ???????????????
          
    func GetPlayListVedios(word:String) {
                let str = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&q=\(word)&type=video&key=AIzaSyAibZHPeSHXEjvT9ATOPxgsyZ8eTx1UGoU"
              var request = URLRequest(url: URL(string: str)!)
              print(str)
              request.httpMethod = "GET"
              let configuration = URLSessionConfiguration.default
              let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
              
              let task = session.dataTask(with: request){ (data, response, error) in
    //               print(response)
                  if (error != nil){
                      print("Error:\(String(describing: error))")
                  }else{
                      do{
                          self.arrChannelVedios.removeAll()
                          let fetchdata = try JSONSerialization.jsonObject(with: data! , options: .mutableLeaves) as? NSDictionary
                          //let nxtPage = fetchdata!["nextPageToken"] as! String
                          print(fetchdata!)
                          if let nxtPage = fetchdata!["nextPageToken"] as? String
                          {
                              self.tokenNum = nxtPage
                          }else{
                              self.tokenNum = ""
                          }
                        if fetchdata!["items"] == nil{
                            return
                        }
                          for eachVedio in fetchdata!["items"] as! NSArray{
                              let vtitle = (eachVedio as AnyObject).value(forKeyPath: "snippet.title") as? String
                              let CId = (eachVedio as AnyObject).value(forKeyPath: "snippet.channelId") as? String
                              let thum = (eachVedio as AnyObject).value(forKeyPath: "snippet.thumbnails.medium.url") as? String
                              var vId = ""
                              let apiVID = (eachVedio as AnyObject).value(forKeyPath: "id.videoId") as? String ?? ""
                              if apiVID == "" {
                                  continue
                              }
                              else{
                                  vId = apiVID
                              }
                              self.arrChannelVedios.append(ChannelVedios(vedioId: vId, channelId: CId!, vedioTitle: vtitle!, thumnail: thum!, tokenNum: self.tokenNum))
                              
                              print(self.arrChannelVedios)
                          }
                          
                          self.channelVediosCollectionView.reloadData()
    //                      self.animationView.isHidden = true
                      }catch{
                          print("Print Error 2")
                      }
                  }
              }
              task.resume()
          }

       
        var fav = [String()]
        func playVideo(videoIdentifier: String?) {
            
//       print(videoIdentifier)
            
            self.present(playerViewController, animated: true, completion: nil)
            NotificationCenter.default.addObserver(self, selector: Selector(("playerDidFinishPlaying:")),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)


            XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
                if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                    playerViewController?.player = AVPlayer(url: streamURL)
                    playerViewController?.player?.play()
    //                                if (playerViewController?.player?.actionAtItemEnd != nil){
    //                                    self.playVideo(videoIdentifier: videoIdentifier)
    //                                    self.playVideo(videoIdentifier: self.arrChannelVedios[1].VedioId)
    //                                   // self.dismiss(animated: true, completion: nil)
    //                                }


                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }


}

var searchtxt = ""

extension SearchVideosViewController : UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
       let searchBarText = searchController.searchBar.text
       if searchBarText == ""{
           return
       }
       if searchBarText == searchtxt{
            return
       }
        searchtxt = searchBarText ?? ""
       self.GetPlayListVedios(word: searchBarText ?? "")
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBarText = searchController.searchBar.text
        if searchBarText == ""{
            return
        }
        self.GetPlayListVedios(word: searchBarText ?? "")
    }

}
