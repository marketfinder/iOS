//
//  NoticeController.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit
import RxSwift
import RxCocoa

class NoticeController: BaseController {
    
    // MARK: - Properties
    private let noticeTableView:BaseTableView = BaseTableView(cellClass: NoticeCell.self, forCellReuseIdentifier: "noticeCell")
    
    private let notices:BehaviorSubject<[Notice]> = BehaviorSubject<[Notice]>(value: [
        Notice(type: 0, date: "2022.08.09", title: "새로운 앱이 업데이트 되었습니다.")
    ])
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        self.navigationItem.title = "NoticeTitle".localized

        self.view.addSubviews(views: [
            self.noticeTableView
        ])
        
        self.setupLayouts()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        self.notices.bind(to: self.noticeTableView.rx.items(cellIdentifier: "noticeCell", cellType: NoticeCell.self)) { (row:Int, notice:Notice, cell:NoticeCell) in
            cell.notice = notice
        }.disposed(by: self.disposeBag)
        
        self.noticeTableView.rx.itemSelected
            .map { $0.row }
            .bind { [weak self] (row:Int) in
                guard let self = self else { return }

                let controller:NoticeDetailController = NoticeDetailController(notice: Notice(type: 0, date: "2022.08.09", title: "새로운 앱이 업데이트 되었습니다."))
                self.navigationController?.pushViewController(controller, animated: true)
            }
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.noticeTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noticeTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.noticeTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.noticeTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
