//
//  MUSectionReadonly.m
//  MUKit
//
//  Created by Malaar on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUSectionReadonly.h"
#import "MUTableDisposer.h"


@implementation MUSectionReadonly


@synthesize headerTitle;
@synthesize footerTitle;
@synthesize headerView;
@synthesize footerView;

#pragma mark - Init/Dealloc

+ (MUSectionReadonly *)section
{
    return [[[self class] alloc] init];
}

- (id)init
{
    if ((self = [super init])) {
        _cellDataSource = [NSMutableArray new];
        _visibleCellDataSource = [NSMutableArray new];
    }
    return self;
}


- (void)setTableDisposer:(MUTableDisposer *)aTableDisposer
{
    _disposer = aTableDisposer;
}

#pragma mark - CellDatas

- (void)addCellData:(MUCellData *)aCellData
{
    [_cellDataSource addObject:aCellData];
}

- (void)addCellDataFromArray:(NSArray *)aCellDataArray
{
    [_cellDataSource addObjectsFromArray:aCellDataArray];
}

- (void)insertCellData:(MUCellData *)aCellData atIndex:(NSUInteger)anIndex
{
    [_cellDataSource insertObject:aCellData atIndex:anIndex];
}

- (void)removeCellDataAtIndex:(NSUInteger)anIndex
{
    [_cellDataSource removeObjectAtIndex:anIndex];
}

- (void)removeAllCellData
{
    [_cellDataSource removeAllObjects];
}

- (MUCellData *)cellDataAtIndex:(NSUInteger)anIndex
{
    return [_cellDataSource objectAtIndex:anIndex];
}

- (MUCellData *)visibleCellDataAtIndex:(NSUInteger)anIndex
{
    return [_visibleCellDataSource objectAtIndex:anIndex];
}

- (NSUInteger)indexByCellData:(MUCellData *)aCellData
{
    return [_cellDataSource indexOfObject:aCellData];
}

- (NSUInteger)indexByVisibleCellData:(MUCellData *)aCellData
{
    return [_visibleCellDataSource indexOfObject:aCellData];
}

- (NSUInteger)cellDataCount
{
    return [_cellDataSource count];
}

- (NSUInteger)visibleCellDataCount
{
    return [_visibleCellDataSource count];
}

- (void)updateCellDataVisibility
{
    [_visibleCellDataSource removeAllObjects];
    for (MUCellData *cellData in _cellDataSource) {
        if (cellData.visible) {
            [_visibleCellDataSource addObject:cellData];
        }
    }
}

#pragma mark - Cells

- (MUCell *)cellForIndex:(NSUInteger)anIndex
{
    MUCell *cell = nil;
    BOOL isNewCell = NO;

    MUCellData *cellData = [self visibleCellDataAtIndex:anIndex];

    cell = [_disposer.tableView dequeueReusableCellWithIdentifier:cellData.cellIdentifier];

    if (!cell) {
        isNewCell = YES;
        cell = [cellData createCell];
    }

    [cell setupCellData:cellData];

    if (isNewCell && _disposer.delegate && [_disposer.delegate respondsToSelector:@selector(tableDisposer:didCreateCell:)]) {
        [_disposer.delegate tableDisposer:_disposer didCreateCell:cell];
    }

    return cell;
}

- (void)reloadWithAnimation:(UITableViewRowAnimation)anAnimation
{
    [self updateCellDataVisibility];
    [_disposer.tableView reloadSections:[NSIndexSet indexSetWithIndex:[_disposer indexBySection:self]] withRowAnimation:anAnimation];
}

- (void)reloadRowsAtIndexes:(NSArray *)anIndexes withAnimation:(UITableViewRowAnimation)aRowAnimation
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSIndexPath *indexPath;
    NSInteger sectionIndex = [_disposer indexBySection:self];
    for (NSNumber *index in anIndexes) {
        indexPath = [NSIndexPath indexPathForRow:[index integerValue] inSection:sectionIndex];
        [indexPaths addObject:indexPath];
    }

    [_disposer.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:aRowAnimation];
}

@end
