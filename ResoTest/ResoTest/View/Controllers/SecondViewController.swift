//
//  TableViewController.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 12.07.2022.
//

import UIKit

class SecondViewController: UIViewController, ResoApiCallerDelegate {
    
    // MARK: Class properties:
    private let viewModel       = SecondViewViewModel()
    private var cellModels      = [OfficeTableViewCellModel]()
    private let filterSegment   = UISegmentedControl(items: ["Списком", "На карте"])
    private let searchBar       = UISearchBar()
    private let contentView     = UIView()
    private let tableView       = UITableView()
    private var screenRect      = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    private var screenWidth     = 0.0
    private var screenHeight    = 0.0
    private var filteredData    = [OfficeTableViewCellModel]()
    private var isSearching     = false

    // MARK: View lifecycles events:
    override func viewDidLoad() {
        super.viewDidLoad()
        screenRect      = UIScreen.main.bounds
        screenWidth     = screenRect.size.width
        screenHeight    = screenRect.size.height

        self.searchBar.delegate = self
        
        view.addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(tableView)
        view.addSubview(filterSegment)
        
        bindViewModel()
        fillTableWithData()
        
        setupNavigationBar()
        setupSegmentedView()
        setupContenView()
        setupSearchBar()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        viewModel.getCurrentLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: Setup UI:
    func setupContenView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: filterSegment.frame.height).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: screenHeight).isActive = true
        contentView.backgroundColor = .white
    }
    func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 55).isActive = true
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = UIColor.white.cgColor
    }
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: screenHeight).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OfficeTableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    func setupNavigationBar() {
        self.view.backgroundColor = #colorLiteral(red: 0.4817662239, green: 0.1368521452, blue: 0.6649298668, alpha: 1)
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Офисы PESO-Обещание"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    func setupSegmentedView() {
        filterSegment.translatesAutoresizingMaskIntoConstraints = false
        filterSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filterSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -3).isActive = true
        filterSegment.widthAnchor.constraint(equalToConstant: screenWidth-30).isActive = true
        filterSegment.heightAnchor.constraint(equalToConstant: 25).isActive = true
        filterSegment.selectedSegmentIndex = 0
        filterSegment.tintColor = UIColor.black
        filterSegment.addTarget(self, action: #selector(self.filterApply), for: UIControl.Event.valueChanged)
        let filterButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
    }
    
    // MARK: ApiCaller error handling with alert:
    func showAlertWithError(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UI action handling:
    @objc private func filterApply(segment: UISegmentedControl) -> Void {
        switch segment.selectedSegmentIndex {
        case 1:
            print(1)
        case 2:
            print(2)
        default:
            print(0)
        }
    }
    @objc private func addTapped() {
        print("tapped")
    }
    
    // MARK: UI binding with ViewModel:
    func bindViewModel() {
        viewModel.cellModels.bind({ (cellModels) in
            self.cellModels = cellModels
        })
        
    }
    
    // MARK: Update table with data from ApiCaller:
    func fillTableWithData() {
        PesoApiCaller.shared.updateOfficesData{ [weak self] result in
            switch result {
            case .success(let models):
                
                self?.viewModel.updateCells(models: models)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(_):
                print("No data")
            }
        }
    }
    
}
// MARK: TableView necessary code:
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData.count
        } else {
            return cellModels.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! OfficeTableViewCell
        
        if isSearching {
            cell.configure(with: filteredData[indexPath.row])
        } else {
            cell.configure(with: cellModels[indexPath.row])
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let thirdViewController = ThirdViewController()
        var data = viewModel.cellModels.value[indexPath.row]
        
        if isSearching {
            data = filteredData[indexPath.row]
        }
        
        thirdViewController.name.text        = data.name
        thirdViewController.adress.text      = data.adress
        thirdViewController.numbers.text     = data.numbers
        thirdViewController.days.text        = data.sgraf
        thirdViewController.latitude         = data.latitude
        thirdViewController.longtitude       = data.longtitude
        navigationController?.pushViewController(thirdViewController, animated: true)
    }
    
    
}
// MARK: SearchBar necessary code:
extension SecondViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        for item in viewModel.cellModels.value {
            let text = searchText.lowercased()
            let isArrayContain = item.name.lowercased().range(of: text)
            
            if isArrayContain != nil {
                //print("Search complete")
                filteredData.append(item)
            }
        }
        
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            tableView.reloadData()
        }
    }
    
    
}
