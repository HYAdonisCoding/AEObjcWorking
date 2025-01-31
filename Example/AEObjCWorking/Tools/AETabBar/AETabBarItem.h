//
//  AETabBarItem.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AETabBarItem : UIView
/*未选中的图片*/
@property (nonatomic,strong) UIImage *image;
/*选中的图片*/
@property (nonatomic,strong) UIImage *selectedImage;
/*标题*/
@property (nonatomic,copy) NSString *title;
/*是否是选中*/
@property (nonatomic,assign) BOOL selected;
/*最大图片尺寸*/
@property (nonatomic,assign) CGSize maxImageSize;
/*最小图片尺寸*/
@property (nonatomic,assign) CGSize minImageSize;
/*文字颜色*/
@property (nonatomic,strong) UIColor *titleColor;
/*选中的文字颜色*/
@property (nonatomic,strong) UIColor *selectedTitleColor;
/*点击*/
@property (nonatomic,strong) void(^selectBlock)(void);
/*更新布局方法 设置完之后记得调用*/
-(void)updateImageAndTitle;
@end

NS_ASSUME_NONNULL_END
