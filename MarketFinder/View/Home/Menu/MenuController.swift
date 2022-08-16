//
//  MenuController.swift
//  MarketFinder
//
//  Created by User on 2022/08/12.
//

import UIKit
import RxGesture
import RxSwift
import RxCocoa

class MenuController: BaseController {
    
    // MARK: - Properties
    private let menuView:BaseView = {
        let view:BaseView = BaseView(color: .white)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        
        return view
    }()
    
    private let menuTableView:BaseTableView = BaseTableView(cellClass: MenuCell.self, forCellReuseIdentifier: "menuCell")
    
    private lazy var menuViewLeftConstant:NSLayoutConstraint = NSLayoutConstraint(item: self.menuView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: -200)
    
    private let menuLists:BehaviorSubject<[String]> = BehaviorSubject<[String]>(value: ["공지사항"])
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.menuView.addSubview(self.menuTableView)
        
        self.view.addSubview(self.menuView)
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        UIView.animate(withDuration: 0.5) {
            self.menuViewLeftConstant.constant = 0
            self.view.layoutIfNeeded()
        }
        
        self.setupLayouts()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        self.menuViewLeftConstant.isActive = true

        NSLayoutConstraint.activate([
            self.menuView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.menuView.widthAnchor.constraint(equalToConstant: 200),
            self.menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.menuTableView.topAnchor.constraint(equalTo: self.menuView.topAnchor),
            self.menuTableView.leftAnchor.constraint(equalTo: self.menuView.leftAnchor),
            self.menuTableView.rightAnchor.constraint(equalTo: self.menuView.rightAnchor),
            self.menuTableView.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor)
        ])
    }
    
    override func bindUI() -> Void {
        self.menuLists.bind(to: self.menuTableView.rx.items(cellIdentifier: "menuCell", cellType: MenuCell.self)) { (row:Int, menu:String, cell:MenuCell) in
            cell.title = menu
        }.disposed(by: self.disposeBag)
        
        self.view.rx.tapGesture(configuration: { (gesture, delegate) in
                gesture.delegate = self
            })
            .when(.recognized)
            .asDriver(onErrorJustReturn: UITapGestureRecognizer())
            .drive(onNext: { gesture in
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuViewLeftConstant.constant = -200
                    self.view.layoutIfNeeded()
                }) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
            })
            .disposed(by: self.disposeBag)
        
        self.menuTableView.rx.itemSelected.map { $0.row }
        .asDriver(onErrorJustReturn: 0)
        .drive(onNext: { (row:Int) in
            self.dismiss(animated: true) {
                let noticeController:NoticeController = NoticeController()
                let navigationController = BaseNavigationController(rootViewController: noticeController)
//                navigationController.pushViewController(, animated: <#T##Bool#>)
                self.navigationController?.pushViewController(noticeController, animated: true)
            }
        }).disposed(by: self.disposeBag)
    }
}
