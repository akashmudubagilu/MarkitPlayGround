//
//  ViewController.h
//  MarkitPlayGround
//
//  Created by Akash Mudubagilu on 7/15/13.
//  Copyright (c) 2013 Akash Mudubagilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

 
@property (weak, nonatomic) IBOutlet UITableView *CompanyDetailsTable;

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;

@property(strong, nonatomic) NSMutableArray *companyArray;
@end
