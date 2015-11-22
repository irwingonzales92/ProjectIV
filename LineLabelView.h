//
//  LineLabelView.h
//  
//
//  Created by Irwin Gonzales on 10/26/15.
//
//

#import <UIKit/UIKit.h>

@interface LineLabelView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic) float lineWidth;

- (id) initWithFrame:(CGRect)frame text:(NSString *)text;
- (id) initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

@end
