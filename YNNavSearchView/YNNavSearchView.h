//
//  YNNavSearchView.h
//  OffsetBrokenViewDemo
//
//  Created by liyangly on 2018/10/19.
//  Copyright © 2018 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNNavSearchView : UIView

@property (nonatomic, strong) NSString *placeholderStr;

@property (nonatomic, copy) void (^searchResult)(void);

@end

NS_ASSUME_NONNULL_END
