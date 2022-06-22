//
//  ProductDetailViewController.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/22.
//

import UIKit

class ProductDetailViewController: UIViewController {

    private let scrollView: UIScrollView = .init()
    private let scrollContainerView: UIView = .init()
    private let borderView: UIView = .init()
    private let pictureImageView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
    private let priceLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()
    private let addToChartButton: UIButton = .init()
    private let purchaseButton: UIButton = .init()
    private let footerView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        return UIVisualEffectView(effect: effect)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mockData()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: Private
private extension ProductDetailViewController {
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(footerView)
        footerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        footerView.contentView.addSubview(addToChartButton)
        addToChartButton.setTitle("加入購物車", for: .normal)
        addToChartButton.setTitleColor(.black, for: .normal)
        addToChartButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.bottom.equalTo(view.snp.bottomMargin).inset(8)
            make.trailing.equalTo(view.snp.centerX)
        }
        
        footerView.contentView.addSubview(purchaseButton)
        purchaseButton.setTitle("立即購買", for: .normal)
        purchaseButton.setTitleColor(.black, for: .normal)
        purchaseButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.centerX)
            make.top.bottom.equalTo(addToChartButton)
            make.trailing.equalToSuperview().inset(8)
        }

        view.insertSubview(scrollView, at: 0)
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(footerView.snp.top)
        }
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.snp.makeConstraints { make in
            make.centerX.leading.trailing.top.bottom.equalToSuperview()
        }

        scrollContainerView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.size.equalTo(320)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
        }
        borderView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        borderView.layer.cornerRadius = 10
        borderView.layer.shadowOpacity = 0.5
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOffset = .init(width: 5, height: 5)

        borderView.addSubview(pictureImageView)
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.clipsToBounds = true
        pictureImageView.layer.cornerRadius = 10
        pictureImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerX.centerY.equalToSuperview()
        }
        pictureImageView.image = UIImage(named: "test")
        scrollContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pictureImageView.snp.bottom).offset(24)
        }
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = .black
        scrollContainerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black.withAlphaComponent(0.8)
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)

        scrollContainerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(descriptionLabel)
            make.bottom.equalToSuperview().inset(16)
        }
        priceLabel.font = .systemFont(ofSize: 20)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
    }
    // FIXME: remove it
    func mockData() {
        titleLabel.text = "Test title 1111111"
        descriptionLabel.text = "skgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnskgnfjlksngklsfnglfsngm,sfng,mfnbgm,sbgn,msbgmnsbgmnsfbgmnsgmnsbgnsbfgmnsbgmnsbgmnsbgmnsfbgmnsbfgihihgnlwrnglwrhtlrwn,tbnwr,mtbnwem,btwbtn,webtmnwebtmnwebtmnewbtmnwebtmnwetmnwebtn,webtwebhtkjwhtkwebt,ewnbtmnwebtmnwbtmwbtmnwbtmnwbtmnwbtmnwbtmnn"
        priceLabel.text = "$qrqwer"
    }
}
