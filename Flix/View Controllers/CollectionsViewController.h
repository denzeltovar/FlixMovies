//
//  CollectionsViewController.h
//  Flix
//
//  Created by denzeltov on 6/26/20.
//  Copyright © 2020 Denzel Tovar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//New view controller that links collectiion views to it's
//own detail view controller
@interface CollectionsViewController : UIViewController
@property (nonatomic, strong) NSDictionary *movie;
//Can you link to different navigation
//controllers to the same view controller?
@end

NS_ASSUME_NONNULL_END
