# RXButtonWithImage
UIButton with image support, which is added to the"safe zone". Availability of basic animation.

<br>
<br>

![Demo](https://raw.githubusercontent.com/m1a7/RXButtonWithImage/master/Screenshot/Apr-04-2018%2023-02-04.gif)


## 1. Init

```objective-c

    // Male button
    UIImage* iconMan = [UIImage imageNamed:@"survey_man"];
    CGRect rectManBtn = CGRectMake(25, 25, 150, 150);
    RXButtonWithImage* btnMan = [[RXButtonWithImage alloc] initWithImage:iconMan withFillColor:[self clrHex:@"#00aabd"] withFrame:rectManBtn];
    [btnMan addTarget:self action:@selector(maleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    // Female button
    UIImage* iconWoman = [UIImage imageNamed:@"survey_woman"];
    CGRect rectWomanBtn = CGRectMake(25, 325, 150, 150);

    RXButtonWithImage* btnWoman = [[RXButtonWithImage alloc]init];
    [btnWoman setIcon:iconWoman];
    [btnWoman setFillColor:[self clrHex:@"#f05159"]];
    [btnWoman setFrame:rectWomanBtn];
    [btnWoman addTarget:self action:@selector(femaleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add to superview
    [self.view addSubview:btnMan];
    [self.view addSubview:btnWoman];

```

## 2. Implement action methods

```objective-c
#pragma mark - Action

- (void) maleBtnClicked:(UIButton*)btn{
    [btn setSelected: !btn.selected];
}

- (void) femaleBtnClicked:(UIButton*)btn{
    [btn setSelected: !btn.selected];
}
```

## 3. (Optional) add hex color method support
```objective-c
#pragma mark - Helpers
- (UIColor *)clrHex:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
```
