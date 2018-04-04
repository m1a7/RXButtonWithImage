//
//  RXButtonWithImage.m
//  RXButtonWithImage
//
//  Created by Uber on 04/04/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "RXButtonWithImage.h"


@interface RXButtonWithImage ()

@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIImageView* iconImgView;
@property (nonatomic, assign) CGRect    safeAreaIcon;

@end

@implementation RXButtonWithImage

#pragma mark - Method which prepare button

- (void) someActionForPrepareButtonBeforeUsing{
    [self setExclusiveTouch:YES];
    [self setBackgroundColor:[UIColor whiteColor]];
    // Around
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = CGRectGetWidth(self.frame)/2;
    
    self.iconImgView             = [[UIImageView alloc] init];
    self.iconImgView.contentMode =  UIViewContentModeScaleAspectFit;
}

#pragma Standart  NSDesignated_Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self someActionForPrepareButtonBeforeUsing];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self someActionForPrepareButtonBeforeUsing];
    }
    return self;
}


#pragma Custom  NSDesignated_Initializers

- (instancetype) initWithImage:(UIImage*) img withFillColor:(UIColor*) fillColor withFrame:(CGRect) frame
{
    self = [super init];
    if (self) {
        [self someActionForPrepareButtonBeforeUsing];
        self.frame = frame;
        self.iconImgView.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        if (fillColor){
            self.fillColor = fillColor;
            [self.iconImgView setTintColor: fillColor];
        }else {
            [self.iconImgView setTintColor: [UIColor whiteColor]];
        }
        self.iconImgView.frame = [self getSafeAreaRectByFrame:frame];
        [self addSubview:_iconImgView];
    }
    return self;
}

#pragma mark - Setters

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
    
    if (self.iconImgView){
        for (UIView* subview in self.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]){
                subview.frame = [self getSafeAreaRectByFrame:frame];
            }
        }
    }
}


- (void) setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    if (self.iconImgView){
        [self.iconImgView setTintColor: fillColor];
    }
}

- (void) setIcon:(UIImage*)img{
    
    self.iconImgView.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    // Типо если не добавлена на кнопку, то добавить...
    if (!self.iconImgView.superview){
        self.iconImgView.frame = [self getSafeAreaRectByFrame:self.frame];
        [self addSubview:_iconImgView];
    }
}


- (CGRect) getSafeAreaRectByFrame:(CGRect)frame{
    // Отнимаем по десять процентов от краев
    float width = CGRectGetWidth(frame);
    float tenPercent = (width/100)*10;
    self.safeAreaIcon =  CGRectMake(tenPercent, tenPercent, width-(tenPercent*2),  width-(tenPercent*2));
    return self.safeAreaIcon;
}


- (void) removeIcon{
    if (!self.iconImgView.superview){
        [self.iconImgView removeFromSuperview];
        self.iconImgView = nil;
    }
}

- (void) setSelected:(BOOL)selected{
    
    if (selected){
        self.backgroundColor = self.fillColor;
        [self.iconImgView setTintColor: [UIColor whiteColor]];
    }else {
        self.backgroundColor = [UIColor whiteColor];
        [self.iconImgView setTintColor:self.fillColor];
    }
    [super setSelected:selected];
}


- (void) setHighlighted:(BOOL)highlighted {
    if (self.userInteractionEnabled && highlighted) {
        
        [UIView animateWithDuration:0.15
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if (self.userInteractionEnabled){
                                 self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                                 self.alpha = 0.5f;
                                 [self setUserInteractionEnabled:NO];
                             }
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.15f
                                              animations:^{
                                                  if (!self.userInteractionEnabled){
                                                      self.transform = CGAffineTransformIdentity;
                                                      self.alpha = 1.f;
                                                      [self setUserInteractionEnabled:YES];
                                                  }
                                              }];
                         }];
    }
}


#pragma mark - Helpers
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
