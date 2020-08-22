//
//  DirectoryItemPresentationCoordinator.swift
//  FileExplorer
//
//  Created by Rafal Augustyniak on 27/11/2016.
//  Copyright (c) 2016 Rafal Augustyniak
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

protocol DirectoryItemPresentationCoordinatorDelegate: class {
    func directoryItemPresentationCoordinator(_ coordinator: DirectoryItemPresentationCoordinator, didSelectItem item: Item<Any>)
    func directoryItemPresentationCoordinator(_ coordinator: DirectoryItemPresentationCoordinator, didSelectItemDetails item: Item<Any>)
    func directoryItemPresentationCoordinator(_ coordinator: DirectoryItemPresentationCoordinator, didChooseItems items: [Item<Any>])
    func directoryItemPresentationCoordinator(_ coordinator: DirectoryItemPresentationCoordinator, didCustomAction items: [Item<Any>])
    func directoryItemPresentationCoordinator(_ coordinator: DirectoryItemPresentationCoordinator, didCustomAction2 items: [Item<Any>])
    func directoryItemPresentationCoordinatorDidFinish(_ coordinator: DirectoryItemPresentationCoordinator)
    func directoryItemPresentationCoordinatorDoSetup(_ coordinator: DirectoryItemPresentationCoordinator)
}

protocol DirectoryItemPresentationCoordinatorToolBarItemsDelegate: class {
    func directoryItemPresentationCoordinatorToolBarItems(items: [UIBarButtonItem])
}

final class DirectoryItemPresentationCoordinator {
    weak var delegate: DirectoryItemPresentationCoordinatorDelegate?
    
    weak var toolBarItemsDelegate: DirectoryItemPresentationCoordinatorToolBarItemsDelegate?

    fileprivate weak var directoryViewController: DirectoryViewController?
    fileprivate var configuration: Configuration

    private let fileService: FileService
    private let fileSpecifications: FileSpecifications
    
    private weak var navigationController: UINavigationController?
    private weak var pushedViewController: UIViewController?

    init(navigationController: UINavigationController, fileSpecifications: FileSpecifications, configuration: Configuration, fileService: FileService = LocalStorageFileService()) {
        self.navigationController = navigationController
        self.fileSpecifications = fileSpecifications
        self.configuration = configuration
        self.fileService = fileService
    }
    
    func start(directoryURL: URL, animated: Bool) {
        //let finishButtonHidden = navigationController?.viewControllers.count != 0
        let finishButtonHidden = true
        
        if directoryURL.hasDirectoryPath {
            
            let viewController = LoadingViewController<Any>.make(item: Item<Any>.directory(at: directoryURL)) { [weak self] loadedItem in
                guard let strongSelf = self else { return nil }
                let loadedItem = loadedItem.cast() as LoadedItem<[Item<Any>]>
                let viewModel = DirectoryViewModel(url: loadedItem.url, item: loadedItem, fileSpecifications: strongSelf.fileSpecifications, configuration: strongSelf.configuration, finishButtonHidden: finishButtonHidden)

                let directoryViewController = DirectoryViewController(viewModel: viewModel)
                directoryViewController.delegate = strongSelf
                strongSelf.directoryViewController = directoryViewController
                return directoryViewController
            }
            
            self.toolBarItemsDelegate = viewController
            navigationController?.pushViewController(viewController, animated: animated)

        } else {
            let viewController = ErrorViewController(errorDescription: "URL is incorrect.", finishButtonHidden: finishButtonHidden)
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}

extension DirectoryItemPresentationCoordinator: DirectoryViewControllerDelegate {
    

    func directoryViewController(_ controller: DirectoryViewController, didSelectItem item: Item<Any>) {
        //directoryViewController?.isSearchControllerActive = false
        delegate?.directoryItemPresentationCoordinator(self, didSelectItem: item)
    }

    func directoryViewController(_ controller: DirectoryViewController, didSelectItemDetails item: Item<Any>) {
       // directoryViewController?.isSearchControllerActive = false
        delegate?.directoryItemPresentationCoordinator(self, didSelectItemDetails: item)
    }
    
    func directoryViewController(_ controller: DirectoryViewController, didChooseItems items: [Item<Any>]) {
        delegate?.directoryItemPresentationCoordinator(self, didChooseItems: items)
    }

    func directoryViewController(_ controller: DirectoryViewController, didCustomAction items: [Item<Any>]) {
        delegate?.directoryItemPresentationCoordinator(self, didCustomAction: items)
    }
    
    func directoryViewController(_ controller: DirectoryViewController, didCustomAction2 items: [Item<Any>]) {
        delegate?.directoryItemPresentationCoordinator(self, didCustomAction2: items)
    }
    
    func directoryViewControllerDidFinish(_ controller: DirectoryViewController) {
        delegate?.directoryItemPresentationCoordinatorDidFinish(self)
    }
    
    func directoryViewControllerDoSetup(_ controller: DirectoryViewController) {
        delegate?.directoryItemPresentationCoordinatorDoSetup(self)
    }
    
    func directoryViewControllerToolBarItems(_ controller: DirectoryViewController) {
        toolBarItemsDelegate?.directoryItemPresentationCoordinatorToolBarItems(items: controller.toolbarItems!)
    }
    
    
}

extension DirectoryItemPresentationCoordinator: ErrorViewControllerDelegate {
    func errorViewControllerDidFinish(_ controller: ErrorViewController) {
        delegate?.directoryItemPresentationCoordinatorDidFinish(self)
    }
}
