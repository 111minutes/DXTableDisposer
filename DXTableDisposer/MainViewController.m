//
//  MainViewController.m
//  DXTableDisposer
//
//  Created by Maks on 31.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "MUTableDisposerModeled.h"
#import "MUCellDataStandart.h"
#import "MUCellDataButton.h"
#import "MUCellDataSwitch.h"
#import "MUCellDataTextField.h"
#import "MUCellDataTextView.h"


@interface MainViewController () 
{
    MUTableDisposerModeled *_tableDisposerModeled;    
    int _curStyle;
}

- (void)configTableDisposerData;
- (void)changeTableStyle;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        _tableDisposerModeled = [MUTableDisposerModeled new];
        _tableDisposerModeled.tableStyle = UITableViewCellStyleValue1;
        [self configTableDisposerData];
        _curStyle = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setView:_tableDisposerModeled.tableView];
    [self setTitle:@"Table Disposer"];    
    [_tableDisposerModeled reloadData];
}

- (void)configTableDisposerData
{
    MUSectionReadonly *studentSection = [MUSectionReadonly new];
    studentSection.headerTitle = @"Students";
    [_tableDisposerModeled addSection:studentSection];
    
    MUCellDataSwitch *pirogofCellDataSwitch = [MUCellDataSwitch new];
    pirogofCellDataSwitch.title = @"Sergey Pirogof";
    pirogofCellDataSwitch.onText = @"increase";
    pirogofCellDataSwitch.offText = @"premium";
    pirogofCellDataSwitch.boolValue = NO;
    [studentSection addCellData:pirogofCellDataSwitch];
    
    MUCellDataButton *kuznetsovCellDataButton = [MUCellDataButton new];
    kuznetsovCellDataButton.title = @"Kuznetsov Maksim \t Enter me for change style";
    kuznetsovCellDataButton.titleFont = [UIFont fontWithName:@"Helvetica" size:13.0f];
    [kuznetsovCellDataButton setTarget:self action:@selector(changeTableStyle)];
    [studentSection addCellData:kuznetsovCellDataButton];
    
    MUSectionReadonly *workersSection = [MUSectionReadonly new];
    workersSection.headerTitle = @"Workers";
    [_tableDisposerModeled addSection:workersSection];
    
    MUCellDataTextField *andreycellDataTextField = [MUCellDataTextField new];
    andreycellDataTextField.title = @"Andrey Fedin";
    andreycellDataTextField.placeholder = @"Enter some task";
    andreycellDataTextField.returnKeyType = UIReturnKeyDone;
    [workersSection addCellData:andreycellDataTextField];    
        
         
    MUCellDataTextView *yuryCellData = [MUCellDataTextView new];
    yuryCellData.title = @"Yury Grinchenko";
    yuryCellData.text = @"this is some text\n teeeeeeeeeeeeeexxxxxxtttt";
    [workersSection addCellData:yuryCellData];
    
    MUSectionReadonly *mastersSection = [MUSectionReadonly new];
    mastersSection.headerTitle = @"Master";
    [_tableDisposerModeled addSection:mastersSection];
    
    MUCellDataStandart *zenCellData = [MUCellDataStandart new];
    zenCellData.title = @"Sergey Zenchenko";
    zenCellData.image = [UIImage imageNamed:@"yoda.jpg"];
    [mastersSection addCellData:zenCellData];

}

- (void)changeTableStyle
{
    _tableDisposerModeled = [MUTableDisposerModeled new];
    int newStyle = arc4random_uniform(3);
    while (_curStyle == newStyle) {
        newStyle = arc4random_uniform(3);
    }
    _curStyle = newStyle;
    switch (arc4random_uniform(3)) {
        case 0:
            _tableDisposerModeled.tableStyle = UITableViewCellStyleDefault;
            break;
        case 1:  
            _tableDisposerModeled.tableStyle = UITableViewCellStyleSubtitle;
            break;
        case 2:
            _tableDisposerModeled.tableStyle = UITableViewCellStyleValue1;
            break;
        case 3:
            _tableDisposerModeled.tableStyle = UITableViewCellStyleValue2;
            break;
    }
    [self configTableDisposerData];
    [self setView:_tableDisposerModeled.tableView];
    [_tableDisposerModeled reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
