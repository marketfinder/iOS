//
//  BaseController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit
import RxSwift

class BaseController: UIViewController {
    
    // MARK: - Properties
    var disposeBag:DisposeBag = DisposeBag()

    // MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Function
    private func baseUI() -> Void {
    }
    
    func bindUI() -> Void {}
    
    func setupLayouts() -> Void {}
    
    // 스낵바 제목 설정
    func setSnackbarTitle(title: String?) -> Void {
        
    }
    
    // 네비게이션 우측 아이콘 설정
    func setRightButton(_ barButtonItem:UIBarButtonItem) -> Void {
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // 네비게이션바 숨김
    func hideNavBar() -> Void {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // 네비게이션바 보이기
    func showNavBar(title: String? = nil) -> Void {
        self.navigationController?.navigationBar.isHidden = false
        
        if let title:String = title {
            self.navigationItem.title = title
        }
    }
    
    // 다음화면으로 이동
    func pushViewController(_ controller: BaseController) -> Void {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // 이전화면으로 이동
    func popViewController() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}
