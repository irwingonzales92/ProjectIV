//
//  LineLabelView.m
//  
//
//  Created by Irwin Gonzales on 10/26/15.
//
//

#import "LineLabelView.h"

#pragma mark -
#pragma mark - definitions

#define DEFAULT_COLOR [UIColor whiteColor]
#define DEFAULT_LINE_WIDTH 0.5f
#define DEFAULT_TEXT @"or"
#define DEFAULT_FONT [UIFont fontWithName:@"OpenSans-Italic" size:14.0f]
#define MARGIN 12


@implementation LineLabelView

#pragma mark -
#pragma mark - initialization
- (id)init
{
    return [self initWithFrame:CGRectZero text:DEFAULT_TEXT font:DEFAULT_FONT color:DEFAULT_COLOR];
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame text:DEFAULT_TEXT font:DEFAULT_FONT color:DEFAULT_COLOR];
}

- (id) initWithFrame:(CGRect)frame text:(NSString *)text
{
    return [self initWithFrame:frame text:text font:DEFAULT_FONT color:DEFAULT_COLOR];
}

- (id) initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];

        _lineColor = DEFAULT_COLOR;
        _lineWidth = DEFAULT_LINE_WIDTH;

        _label = [self initializeLabelWithText:text font:font color:color];
        [self addSubview:_label];
        [self setupConstraints];
        [self setNeedsDisplay];
    }

    return self;
}

#pragma mark -
#pragma mark - setup
- (void)setupConstraints
{
    // Center horizontally
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_label
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];

    // Center vertically
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_label
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
}


- (UILabel*)label
{
    return [self initializeLabelWithText:DEFAULT_TEXT font:DEFAULT_FONT color:DEFAULT_COLOR];
}

- (UILabel *)initializeLabelWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{

    if (_label == nil)
    {
        _label = [[UILabel alloc] init];
        _label.text = text;
        _label.font = font;
        _label.textColor = color;
        [_label sizeToFit];
        _label.translatesAutoresizingMaskIntoConstraints = NO;

        [self addSubview:_label];
    }
    return _label;
}



#pragma mark -
#pragma mark - drawRect
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the line color and width
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    //Start a new Path
    CGContextBeginPath(context);

    CGContextSetLineWidth(context, 0.5f);
    CGContextMoveToPoint(context, 0.0f, self.label.center.y);
    CGContextAddLineToPoint(context, _label.frame.origin.x - MARGIN , self.label.center.y);
    CGContextMoveToPoint(context, _label.frame.origin.x + self.label.frame.size.width + MARGIN, self.label.center.y);
    CGContextAddLineToPoint(context, self.frame.size.width, self.label.center.y);

    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}


@end
