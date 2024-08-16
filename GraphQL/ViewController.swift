//
//  ViewController.swift
//  GraphQL
//
//  Created by vaishanavi.sasane on 14/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblView: UITableView!
    
    /// Variables
    var arrCountryList: [GraphQL.CountryListQuery.Data.CountryList.Datum?]? = []
    var access_Token: String = "''"
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.defaultCell)
        tblView.dataSource = self
        tblView.delegate = self
        self.loginDataMutation()
        self.getCountryList()
    }
    
    /// Get Country List
    func getCountryList()  {
        self.countryListQuery { success, message in
            if success {
                self.tblView.reloadData()
            }
            debugPrint(message)
        }
    }
    
    /// Get Country List Requests (Query)
    func countryListQuery(completionBlock: @escaping (Bool, String) -> Void ) {
        Network.shared.callQueryAPI(model: GraphQL.CountryListQuery()) { [weak self] result in
            guard let weakSelf = self else { return }
            guard let result = result.data?.countryList else { return }
            self?.arrCountryList = result.data
            if let data =  weakSelf.arrCountryList {
                for country in data {
                    print("Name: ",country?.name ?? "")
                }
            }
            print("Responce:",result)
            completionBlock(true, result.meta.message)
        } failureBlock: { [weak self] error in
            print(error)
            guard self != nil else { return }
            completionBlock(false, error.errorMessage ?? "")
        }
    }
    
    /// Get login data Requests (Mutation)
    func loginDataMutation() {
        Network.shared.callMutationApi(param: GraphQL.LoginMutation.init(email: "abc@gmail.com", password: "abc")) { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.access_Token = result.data?.login.data.access_token ?? ""
        } FailureBlock: { error in
            debugPrint(error.errorMessage ?? "")
        }

    }
}

/// TableView - Delagate & Datasource
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrCountryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.defaultCell, for: indexPath)
        cell.textLabel?.text = self.arrCountryList?[indexPath.row]?.name
        return cell
    }
}

