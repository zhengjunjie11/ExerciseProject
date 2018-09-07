//
//  BaseViewController.h
//  ExerciseProject
//
//  Created by 天空吸引我 on 2018/8/25.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

//NavBar高度
#define NavigationBar_HEIGHT 44.0
//statusbar 高度
#define STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController


@end


