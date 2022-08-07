//
//  ViewController.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 12.07.2022.
//

import UIKit

class FirstViewController: UIViewController, ResoApiCallerDelegate {
    
    // MARK: Class properties:
    private var viewModel   = FirstViewViewModel()
    private var officesData = [Office]()
    private let button      = UIButton(frame: CGRect(x: 0, y: 0, width: 165, height: 50))

    // MARK: View lifecycles events:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.view.addSubview(button)
        bindViewModel()
        viewModel.updateButtonText()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButton()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    // MARK: ApiCaller error handling with alert:
    func showAlertWithError(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: Setup UI:
    private func setupButton() {
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.center = self.view.center
        button.titleLabel?.font = UIFont(name: "Avenir", size: 16)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = button.frame.height/5.0
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
    }
    
    // MARK: UI binding with ViewModel:
    private func bindViewModel() {
        viewModel.buttonText.bind({ (buttonText) in
            DispatchQueue.main.async {
                self.button.setTitle(buttonText, for: .normal)
            }
        })
    }
    
    // MARK: UI action handling:
    @objc private func buttonPressed() {
        button.backgroundColor = .gray
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}

