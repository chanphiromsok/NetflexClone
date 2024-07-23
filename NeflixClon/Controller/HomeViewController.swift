//
//  HomeViewController.swift
//  NeflixClon
//
//  Created by rom on 19/07/2024.
//

import UIKit
enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}
class HomeViewController: UIViewController {
    let sectionTitles = ["Trending Movie","Trending Tv","Popular","Upcoming Movies","Top rated"]
    //   closure style
    private let homeTableView : UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identify)
        return table
    }()
    
    private func configureNavBar() {
        let image  = UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,  style: .done, target:  self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        
        homeTableView.delegate = self //create render section expose via tableView
        homeTableView.dataSource = self
        configureNavBar()
        let headerView = HeroHeaderUIView(frame: CGRect(x: -100, y: 100, width: view.bounds.width, height: 380))
        //        Add Header To TableList
        homeTableView.tableHeaderView = headerView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // give the whole bound of the screen
        homeTableView.frame = view.bounds
    }
    
    
    
}

extension  HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identify,for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                    
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                    
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    debugPrint(error)
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result {
                    
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    debugPrint(error)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    debugPrint(error)
                }
            }
        default:
            return UITableViewCell()
            
        }
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    //  we have 20section  one section one row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if value greater than cell height it will grow to 2row
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // Check CollectionViewTableViewCell itemSize use height 200 to estimated
        return 200
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18,weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text =  header.textLabel?.text?.captalizeFirstLetter()
        //        seem not work
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        
    }
    //    transform navigationBar when scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
