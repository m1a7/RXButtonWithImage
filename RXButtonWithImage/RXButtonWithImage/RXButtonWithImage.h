//
//  RXButtonWithImage.h
//  RXButtonWithImage
//
//  Created by Uber on 04/04/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXButtonWithImage : UIButton

- (instancetype) initWithImage:(UIImage*) img withFillColor:(UIColor*) fillColor withFrame:(CGRect) frame;

- (void) removeIcon;
- (void) setIcon:(UIImage*)img;
- (void) setFrame:(CGRect)frame;
- (void) setFillColor:(UIColor *)fillColor;

@end
