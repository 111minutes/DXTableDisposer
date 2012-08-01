//
//  MUTableDisposer.m
//  MUKit
//
//  Created by Malaar on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUTableDisposer.h"
#import "MUKeyboardAvoidingTableView.h"


@interface MUTableDisposer ()

- (UITableView *)createTableView;

@end

@implementation MUTableDisposer


@synthesize tableClass = _tableClass;
@synthesize tableStyle = _tableStyle;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;


- (id)init
{
    if ((self = [super init])) {
        _sections = [NSMutableArray new];
        _tableClass = [UITableView class];
        _tableStyle = UITableViewStylePlain;
    }
    return self;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [self createTableView];
    }
    return _tableView;
}

- (UITableView *)createTableView
{
    UITableView *tv = [[_tableClass alloc] initWithFrame:CGRectZero style:_tableStyle];
    tv.dataSource = self;
    tv.delegate = self;
    return tv;
}

- (void)releaseView
{
    _tableView = nil;
}

- (void)addSection:(MUSectionReadonly *)aSection
{
    [_sections addObject:aSection];
    [aSection setTableDisposer:self];
}

- (void)removeSectionAtIndex:(NSUInteger)anIndex needUpdateTable:(BOOL)aNeedUpdateTable
{
    if (aNeedUpdateTable) {
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:anIndex] withRowAnimation:UITableViewRowAnimationMiddle];
    }

    [_sections removeObjectAtIndex:anIndex];
}

- (void)removeSection:(MUSectionReadonly *)aSection needUpdateTable:(BOOL)aNeedUpdateTable
{
    NSUInteger index = [self indexBySection:aSection];
    [self removeSectionAtIndex:index needUpdateTable:aNeedUpdateTable];
}

- (void)removeAllSections
{
    [_sections removeAllObjects];
}

- (MUSectionReadonly *)sectionByIndex:(NSUInteger)anIndex
{
    return [_sections objectAtIndex:anIndex];
}

- (NSUInteger)indexBySection:(MUSectionReadonly *)aSection
{
    return [_sections indexOfObject:aSection];
}

- (NSUInteger)sectionsCount
{
    return [_sections count];
}

- (NSIndexPath *)indexPathByCellData:(MUCellData *)aCellData
{
    NSIndexPath *result = nil;

    NSUInteger rowIndex = NSNotFound;
    NSUInteger secIndex = 0;
    for (MUSectionReadonly *section in _sections) {
        rowIndex = [section indexByCellData:aCellData];
        if (rowIndex != NSNotFound) {
            result = [NSIndexPath indexPathForRow:rowIndex inSection:secIndex];
        }
        secIndex++;
    }

    return result;
}

- (NSIndexPath *)indexPathByVisibleCellData:(MUCellData *)aCellData
{
    NSIndexPath *result = nil;

    NSUInteger rowIndex = NSNotFound;
    NSUInteger secIndex = 0;
    for (MUSectionReadonly *section in _sections) {
        rowIndex = [section indexByVisibleCellData:aCellData];
        if (rowIndex != NSNotFound) {
            result = [NSIndexPath indexPathForRow:rowIndex inSection:secIndex];
        }
        secIndex++;
    }

    return result;
}

- (MUCellData *)cellDataByIndexPath:(NSIndexPath *)anIndexPath
{
    return [[self sectionByIndex:anIndexPath.section] cellDataAtIndex:anIndexPath.row];
}

- (MUCellData *)visibleCellDataByIndexPath:(NSIndexPath *)anIndexPath
{
    return [[self sectionByIndex:anIndexPath.section] visibleCellDataAtIndex:anIndexPath.row];
}

- (void)hideCellByIndexPath:(NSIndexPath *)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable
{
    MUSectionReadonly *section = [self sectionByIndex:anIndexPath.section];
    if ([section isKindOfClass:[MUSectionWritable class]]) {
        [(MUSectionWritable *) section hideCellByIndex:anIndexPath.row needUpdateTable:aNeedUpdateTable];
    }
}

- (void)showCellByIndexPath:(NSIndexPath *)anIndexPath needUpdateTable:(BOOL)aNeedUpdateTable
{
    MUSectionReadonly *section = [self sectionByIndex:anIndexPath.section];
    if ([section isKindOfClass:[MUSectionWritable class]]) {
        [(MUSectionWritable *) section showCellByIndex:anIndexPath.row needUpdateTable:aNeedUpdateTable];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [[self sectionByIndex:section] visibleCellDataCount];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self sectionByIndex:indexPath.section] cellForIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return [_sections count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    return [self sectionByIndex:section].headerTitle;
}

- (NSString *)tableView:(UITableView *)aTableView titleForFooterInSection:(NSInteger)section
{
    return [self sectionByIndex:section].footerTitle;
}

- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView: canEditRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView canEditRowAtIndexPath:indexPath];
    }
    return result;
}

- (BOOL)tableView:(UITableView *)aTableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView: canMoveRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView canMoveRowAtIndexPath:indexPath];
    }
    return result;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView
{
    NSArray *result = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        result = [_delegate sectionIndexTitlesForTableView:aTableView];
    }
    return result;
}

- (NSInteger)tableView:(UITableView *)aTableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger result = NSNotFound;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView: sectionForSectionIndexTitle:atIndex:)]) {
        result = [_delegate tableView:aTableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return result;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [_delegate tableView:aTableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)aTableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [_delegate tableView:aTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableView_delegate

- (void)tableView:(UITableView *)aTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [_delegate tableView:aTableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUCellData *cellData = [[self sectionByIndex:indexPath.section] visibleCellDataAtIndex:indexPath.row];
    return [cellData cellHeightForWidth:aTableView.bounds.size.width];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat result = 0;
    if ([self sectionByIndex:section].headerView) {
        result = [self sectionByIndex:section].headerView.bounds.size.height;
    }
    else if ([[self sectionByIndex:section].headerTitle length]) {
        result = 20;
    }

//    return [self sectionByIndex:section].headerView ? [self sectionByIndex:section].headerView.bounds.size.height : 20;
    return result;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForFooterInSection:(NSInteger)section
{
    CGFloat result = 0;
    if ([self sectionByIndex:section].footerView) {
        result = [self sectionByIndex:section].footerView.bounds.size.height;
    }
    else if ([[self sectionByIndex:section].footerTitle length]) {
        result = 20;
    }

    return result;
//    return [self sectionByIndex:section].footerView ? [self sectionByIndex:section].footerView.bounds.size.height : 20;
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionByIndex:section].headerView;
}

- (UIView *)tableView:(UITableView *)aTableView viewForFooterInSection:(NSInteger)section
{
    return [self sectionByIndex:section].footerView;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUCellData *cellData = [[self sectionByIndex:indexPath.section] visibleCellDataAtIndex:indexPath.row];
    if (cellData) {
        [cellData performSelectedHandlers];
    }

    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_delegate tableView:aTableView didSelectRowAtIndexPath:indexPath];
    }

    if (cellData && cellData.autoDeselect) {
        [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)tableView:(UITableView *)aTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MUCellData *cellData = [[self sectionByIndex:indexPath.section] visibleCellDataAtIndex:indexPath.row];
    if (cellData) {
        [cellData performDeselectedHandlers];
    }

    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [_delegate tableView:aTableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView: accessoryButtonTappedForRowWithIndexPath:)]) {
        [_delegate tableView:aTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)aTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *result = indexPath;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView willSelectRowAtIndexPath:indexPath];
    }
    return result;
}

- (NSIndexPath *)tableView:(UITableView *)aTableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *result = indexPath;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView willDeselectRowAtIndexPath:indexPath];
    }
    return result;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView editingStyleForRowAtIndexPath:indexPath];
    }
    return result;
}

- (NSString *)tableView:(UITableView *)aTableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *result = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return result;
}

- (BOOL)tableView:(UITableView *)aTableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return result;
}

- (void)tableView:(UITableView *)aTableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [_delegate tableView:aTableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)aTableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [_delegate tableView:aTableView didEndEditingRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)aTableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSIndexPath *result = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        result = [_delegate tableView:aTableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return result;
}

- (NSInteger)tableView:(UITableView *)aTableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger result = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return result;
}

- (BOOL)tableView:(UITableView *)aTableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        result = [_delegate tableView:aTableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return result;
}

- (BOOL)tableView:(UITableView *)aTableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    BOOL result = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        result = [_delegate tableView:aTableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return result;
}

- (void)tableView:(UITableView *)aTableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [_delegate tableView:aTableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

- (void)reloadData
{
    if ([_tableView isKindOfClass:[MUKeyboardAvoidingTableView class]]) {
        [((MUKeyboardAvoidingTableView *) _tableView) removeAllObjectForKeyboard];
    }

    for (MUSectionReadonly *section in _sections) {
        [section updateCellDataVisibility];
    }

    [_tableView reloadData];
}

- (void)reloadSectionsWithAnimation:(UITableViewRowAnimation)anAnimation
{
    for (MUSectionReadonly *section in _sections) {
        [section reloadWithAnimation:anAnimation];
    }
}


#pragma mark - UIScrollView_delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [_delegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [_delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIView *view = nil;
    if (_delegate && [_delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        view = [_delegate viewForZoomingInScrollView:scrollView];
    }
    return view;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [_delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [_delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;   // return a yes if you want to scroll to the top. if not defined, assumes YES
{
    BOOL result = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        result = [_delegate scrollViewShouldScrollToTop:scrollView];
    }
    return result;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_delegate scrollViewDidScrollToTop:scrollView];
    }
}

@end
