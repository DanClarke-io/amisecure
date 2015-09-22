//
//  breachListViewController.h
//  amisecure
//
//  Created by Work on 25/02/2014.
//  Copyright (c) 2014 OverByThere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LazyInternet.h"

@interface breachListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    LazyInternet *getList;
    NSMutableArray *ourBreachList;
}


@end
