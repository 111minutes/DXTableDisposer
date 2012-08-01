//
//  MUSectionReadonly.h
//  MUKit
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUCell.h"
#import "MUCellData.h"

@class MUTableDisposer;

@interface MUSectionReadonly : NSObject
{
    NSMutableArray *_cellDataSource;
    NSMutableArray *_visibleCellDataSource;
    MUTableDisposer *_disposer;
}

@property(nonatomic, copy) NSString *headerTitle;
@property(nonatomic, copy) NSString *footerTitle;
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) UIView *footerView;

+ (MUSectionReadonly *)section;

- (void)setTableDisposer:(MUTableDisposer *)aTableDisposer;

- (void)addCellData:(MUCellData *)aCellData;
- (void)addCellDataFromArray:(NSArray *)aCellDataArray;
- (void)insertCellData:(MUCellData *)aCellData atIndex:(NSUInteger)anIndex;
- (void)removeCellDataAtIndex:(NSUInteger)anIndex;
- (void)removeAllCellData;
- (NSUInteger)cellDataCount;
- (NSUInteger)visibleCellDataCount;

- (MUCellData *)cellDataAtIndex:(NSUInteger)anIndex;
- (MUCellData *)visibleCellDataAtIndex:(NSUInteger)anIndex;
- (NSUInteger)indexByCellData:(MUCellData *)aCellData;
- (NSUInteger)indexByVisibleCellData:(MUCellData *)aCellData;

- (void)updateCellDataVisibility;

- (MUCell *)cellForIndex:(NSUInteger)anIndex;

- (void)reloadWithAnimation:(UITableViewRowAnimation)anAnimation;
- (void)reloadRowsAtIndexes:(NSArray *)anIndexes withAnimation:(UITableViewRowAnimation)aRowAnimation;

@end
