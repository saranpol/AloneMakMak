//
//  ViewUtil.h
//  Panda
//
//  Created by saranpol on 10/13/56 BE.
//  Copyright (c) 2556 saranpol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewUtil : NSObject

typedef void (^RemoveViewDone)();

+ (void)addViewFade:(UIView*)parent view:(UIView*)v;
+ (void)addViewFade:(UIView*)parent view:(UIView*)v finalAlpha:(CGFloat)finalAlpha;
+ (void)removeViewFade:(UIView*)v completion:(RemoveViewDone)completion;
+ (void)setFrameHeight:(UIView*)v h:(CGFloat)h;
+ (void)setFrameWidth:(UIView*)v w:(CGFloat)w;
+ (void)setFrame:(UIView*)v x:(CGFloat)x y:(CGFloat)y;
+ (void)setFrame:(UIView*)v x:(CGFloat)x;
+ (void)setFrame:(UIView*)v y:(CGFloat)y;
+ (UIImage*)getInsetImage:(UIImage*)image;
+ (CGFloat)getLabelHeight:(UILabel*)label;

@end
