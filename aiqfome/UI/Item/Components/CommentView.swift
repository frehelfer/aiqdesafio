//
//  CommentView.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 13/11/23.
//

import UIKit

protocol CommentViewDelegate: AnyObject {
    func addComment(text: String)
}

class CommentView: UIView, MyAbstractFactory {
    
    weak var delegate: CommentViewDelegate?
    
    private enum Params {
        static let placeholder = "alguma observação do item? • opcional \nex: tirar algum ingrediente, ponto do prato"
    }
    
    // MARK: - Properties
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.grayDefault.cgColor
        view.font = .customFont(ofSize: 14, weight: .semiBold)
        view.textColor = .textSecondary
        view.delegate = self
        view.isScrollEnabled = true
        return view
    }()
    
    // MARK: - Init
    init(delegate: CommentViewDelegate, text: String) {
        self.delegate = delegate
        super.init(frame: .zero)
        textView.text = text.isEmpty ? Params.placeholder : text
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension CommentView: ViewCode {
    func addSubviews() {
        addSubview(textView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // backgroundView
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 58),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .whiteDefault
    }
}

// MARK: - UITextViewDelegate
extension CommentView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // placeholder
        if textView.textColor == .textSecondary {
            textView.text = nil
            textView.textColor = .textPrimary
        }
        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        // placeholder
        if textView.text.isEmpty {
            textView.text = Params.placeholder
            textView.textColor = .textSecondary
        }
        delegate?.addComment(text: textView.text)
    }
    
}
