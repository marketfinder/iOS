//
//  NoticeDetailController.swift
//  MarketFinder
//
//  Created by User on 2022/08/16.
//

import UIKit
import RxSwift
import RxCocoa
import FontAwesome_swift

class NoticeDetailController: BaseController {
 
    // MARK: - Properties
    private let noticeView:NoticeView = NoticeView()
    
    private let lineView:BaseView = BaseView(color: .gray)
    
    private let noticeDetailTextView:BaseTextView = {
        let textView:BaseTextView = BaseTextView()
        textView.font = textView.font?.withSize(20)
        textView.isEditable = false
        
        return textView
    }()
    
    private let backButttonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage.fontAwesomeIcon(name: .arrowLeft, style: .solid, textColor: .black, size: CGSize(width: 25, height: 25)), style: .plain, target: nil, action: nil)
    
    // MARK: - Life Cycle
    init(notice: Notice) {
        super.init()
        
        noticeView.setNotice(notice: notice)
        
        self.view.addSubviews(views: [
            self.noticeView,
            self.lineView,
            self.noticeDetailTextView
        ])
        
        Observable.of("NoticeTitle".localized)
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: self.disposeBag)
        
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        
        self.navigationItem.setLeftBarButton(backButttonItem, animated: true)
        
        Observable.of("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            .bind(to: self.noticeDetailTextView.rx.text)
            .disposed(by: self.disposeBag)
        
        self.bindUI()
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func bindUI() {
        self.backButttonItem.rx.tap
            .debounce(.microseconds(500), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                guard let self:NoticeDetailController = self else { return }

                self.navigationController?.popViewController(animated: true)
            }).disposed(by: self.disposeBag)
    }
    
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.noticeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.noticeView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
            self.noticeView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
            self.noticeView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.lineView.topAnchor.constraint(equalTo: self.noticeView.bottomAnchor, constant: 5),
            self.lineView.leftAnchor.constraint(equalTo: self.noticeView.leftAnchor),
            self.lineView.rightAnchor.constraint(equalTo: self.noticeView.rightAnchor),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),

            self.noticeDetailTextView.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 5),
            self.noticeDetailTextView.leftAnchor.constraint(equalTo: self.noticeView.leftAnchor),
            self.noticeDetailTextView.rightAnchor.constraint(equalTo: self.noticeView.rightAnchor),
            self.noticeDetailTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
