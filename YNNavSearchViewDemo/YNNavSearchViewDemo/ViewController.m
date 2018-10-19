//
//  ViewController.m
//  YNNavSearchViewDemo
//
//  Created by liyangly on 2018/10/19.
//  Copyright © 2018 liyang. All rights reserved.
//

#import "ViewController.h"
// view
#import "YNNavSearchView.h"

@interface ViewController ()

@property (nonatomic, strong) YNNavSearchView *searchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.searchView;
}

#pragma mark - Getters
- (YNNavSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[YNNavSearchView alloc] init];
//        _searchView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40);
    }
    return _searchView;
}

@end
