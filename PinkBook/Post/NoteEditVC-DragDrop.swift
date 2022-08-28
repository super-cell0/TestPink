//
//  NoteEditVC-DragDrop.swift
//  PinkBook
//
//  Created by beidixiaoxiong on 2022/8/28.
//

import UIKit

//MARK: -拖拽移动
extension NoteEditViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //可用indexpath判断某section或某item是否可拖动,若不可拖动则返回空数组
        let photo = photos[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photos[indexPath.item]))
        dragItem.localObject = photo
        return [dragItem]
    }
    //若一次拖动多个,需实现itemsForAddingTo方法
    //若要改变拖拽时cell外观,需实现dragPreviewParametersForItemAt方法
    
}

extension NoteEditViewController: UICollectionViewDropDelegate {
    //正在拖拽
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        //print("正在拖拽")
        //DropProposal--放开cell的方案
        //若需实现section间不可拖拽的功能:可定全局变量dragingIndexPath(拖拽起始位置)，在itemsForBeginning中赋值为indexPath，然后对比他的section是否等于destinationIndexPath(拖拽结束位置)的section，若不等于则返回forbidden，
        //可用session.localDragSession来判断是否在同一app中操作
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    
        //coordinator协调器，类似于context上下文，iOS中常用的获取之前数据的机制
        //若不是在本app中拖拽cell（如iPad中可拖拽图片进app以上传图片功能），则coordinator.destinationIndexPath为nil
        if coordinator.proposal.operation == .move,
           let coordinatorItem = coordinator.items.first,//拖拽单个故获取first即可
           let sourceIndexPath = coordinatorItem.sourceIndexPath,
           let destinationIndexPath = coordinator.destinationIndexPath {
            //将多个操作合并为一个动画
            collectionView.performBatchUpdates {
                photos.remove(at: sourceIndexPath.item)
                photos.insert(coordinatorItem.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            //固定操作,让拖拽变得自然
            coordinator.drop(coordinatorItem.dragItem, toItemAt: destinationIndexPath)

        }
    }
    
    
}
