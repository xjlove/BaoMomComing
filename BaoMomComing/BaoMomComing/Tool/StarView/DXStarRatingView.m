/*
 Copyright (c) 2014 Selvin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "DXStarRatingView.h"

#define kStarPadding 1.0

#define kRatingStarOnImage [UIImage imageNamed:@"large_star_full.png"]
#define kRatingStarOffImage [UIImage imageNamed:@"large_star_empty.png"]

@interface DXStarRatingView () {
    int _stars;
    id _target;
    SEL _callBackAction;
    DXStarRatingViewCallBack _callBackBlock;
    
    BOOL _isInitialized;
}

@end

@implementation DXStarRatingView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    self.lowStar = @0;
    [self performSelector:@selector(setupInterface) withObject:nil afterDelay:0.1];
}

- (void)setStars:(int)stars {
    _stars = stars;
    [self setupInterface];
}

- (void)setStars:(int)stars callbackBlock:(DXStarRatingViewCallBack)callBackBlock {
    _stars = stars;
    [self setupInterface];
    _callBackBlock = [callBackBlock copy];
}

- (void)setStars:(int)stars target:(id)target callbackAction:(SEL)callBackAction {
    _stars = stars;
    _target = target;
    _callBackAction = callBackAction;
    [self setupInterface];
}

- (void)setupInterface {
    if (_isInitialized) {
        //if the star rating view is already set then no need to do it all over again
        [self updateStarUI];
        return;
    }
    [[self subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIImage *starImageOn = kRatingStarOnImage;
    UIImage *starImageOff = kRatingStarOffImage;
    
//    CGRect frame = self.frame;
//    frame.size.height = starImageOn.size.height;
//    frame.size.width = starImageOn.size.width*5+4*kStarPadding;
//    self.frame = frame;
    
    originX = (self.frame.size.width-132)/2;
    for (int counter=1; counter<=5; counter++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:(counter<=_stars)?starImageOn:starImageOff];
        [imageView sizeToFit];
        imageView.frame = CGRectMake(originX+(counter-1)*28, 4, 20, 20);
//        frame = imageView.frame;
//        frame.origin.x = xOrigin;
//        frame.origin.y = 0;
//        imageView.frame = frame;
        imageView.tag = counter;
        
        [self addSubview:imageView];
    }
    _isInitialized = YES;
}

- (void)updateStarUI {
    UIImage *starImageOn = kRatingStarOnImage;
    UIImage *starImageOff = kRatingStarOffImage;
    
    for (int counter=1; counter<=5; counter++) {
        UIImageView *imageView = (UIImageView*)[self viewWithTag:counter];
        imageView.image = (counter <= _stars) ? starImageOn : starImageOff;
    }

}

#define kQuarterStarDivident 20.0

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleStarTouches:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleStarTouches:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleStarTouches:touches withEvent:event];
    [self performCallBackWithStarValue];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self updateStarUI];
    [self performCallBackWithStarValue];
}

- (void)handleStarTouches:(NSSet *)touches withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.bounds, [[[touches allObjects] lastObject] locationInView:self])) {
        
        float xpos = [[[touches allObjects] lastObject] locationInView:self].x;
        if (xpos <= originX) {
            if ([self.lowStar intValue] > 0) {
                _stars = 1;
            }else {
                _stars = 0;
            }
        }else if (xpos > originX && xpos <= originX+28) {
            _stars = 1;
        }else if (xpos > originX+28 && xpos <= originX+56) {
            _stars = 2;
        }else if (xpos > originX+56 && xpos <= originX+84) {
            _stars = 3;
        }else if (xpos > originX+84 && xpos <= originX+112) {
            _stars = 4;
        }else {
            _stars = 5;
        }
//        _stars = xpos/(self.bounds.size.width/5.0f)+1;
//        NSLog(@"xpos = %f, stars = %d", xpos, _stars);
//        
//        if (_stars == 1) {
//            if (xpos<(self.bounds.size.width/kQuarterStarDivident)) {
//                //if user slides below half star then make it zero
//                _stars = 0;
//            }
//        }
        [self updateStarUI];
    }
}

#pragma mark - call back target -

- (void)performCallBackWithStarValue {
    if (_callBackAction) {
       [_target performSelectorOnMainThread:_callBackAction withObject:@(_stars) waitUntilDone:YES];
    }
    if (_callBackBlock) {
        _callBackBlock(@(_stars));
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return NO;
}

@end
