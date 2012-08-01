//
//  DCRoundSwitch.m
//
//  Created by Patrick Richards on 28/06/11.
//  MIT License.
//
//  http://twitter.com/patr
//  http://domesticcat.com.au/projects
//  http://github.com/domesticcatsoftware/DCRoundSwitch
//

#import "DCRoundSwitch.h"
#import "DCRoundSwitchToggleLayer.h"
#import "DCRoundSwitchOutlineLayer.h"
#import "DCRoundSwitchKnobLayer.h"

@interface DCRoundSwitch ()

- (void)setup;
- (void)useLayerMasking;
- (void)removeLayerMask;
- (void)positionLayersAndMask;

@end

@implementation DCRoundSwitch
@synthesize on, onText, offText;
@synthesize onTintColor;

#pragma mark -
#pragma mark Init & Memory Managment


- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 77, 27);
        [self setup];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }

    return self;
}

- (void)setup
{
    // this way you can set the background color to black or something similar so it can be seen in IB
    self.backgroundColor = [UIColor clearColor];

    // remove the flexible width/height autoresizing masks if they have been set
    UIViewAutoresizing mask = (int) self.autoresizingMask;
    if (mask & UIViewAutoresizingFlexibleHeight)
        self.autoresizingMask ^= UIViewAutoresizingFlexibleHeight;

    if (mask & UIViewAutoresizingFlexibleWidth)
        self.autoresizingMask ^= UIViewAutoresizingFlexibleWidth;

    // setup default texts
    self.onText = NSLocalizedString(@"ON", @"Used inside switches");
    self.offText = NSLocalizedString(@"OFF", @"Used inside switches");

    // the switch has three layers, (ordered from bottom to top):
    //
    // * toggleLayer * (bottom of the layer stack)
    // this layer contains the onTintColor (blue by default), the text, and the shadown for the knob.  the knob shadow is
    // on this layer because it needs to go under the outlineLayer so it doesn't bleed out over the edge of the control.
    // this layer moves when the switch moves

    // * outlineLayer * (middle of the layer stack)
    // this is the outline of the control, it's inner shadow, and the inner gloss.  the inner shadow is on this layer
    // because it must stay still while the switch animates.  the inner gloss is also here because it doesn't move, and also
    // because it needs to go uner the knobLayer.
    // this layer appears to always stay in the same spot.

    // * knobLayer * (top of the layer stack)
    // this is the knob, and sits on top of the layer stack. note that the knob shadow is NOT drawn here, it is drawn on the
    // toggleLayer so it doesn't bleed out over the outlineLayer.

    _toggleLayer = [[DCRoundSwitchToggleLayer alloc] initWithOnString:self.onText offString:self.offText onTintColor:[UIColor colorWithRed:0.000 green:0.478 blue:0.882 alpha:1.0]];
    _toggleLayer.drawOnTint = NO;
    _toggleLayer.clip = YES;
    [self.layer addSublayer:_toggleLayer];
    [_toggleLayer setNeedsDisplay];

    _outlineLayer = [DCRoundSwitchOutlineLayer layer];
    [_toggleLayer addSublayer:_outlineLayer];
    [_outlineLayer setNeedsDisplay];

    _knobLayer = [DCRoundSwitchKnobLayer layer];
    [self.layer addSublayer:_knobLayer];
    [_knobLayer setNeedsDisplay];

    _toggleLayer.contentsScale = _outlineLayer.contentsScale = _knobLayer.contentsScale = [[UIScreen mainScreen] scale];

    // tap gesture for toggling the switch
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(tapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];

    // pan gesture for moving the switch knob manually
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(toggleDragged:)];
    [self addGestureRecognizer:panGesture];

    // call setFrame: manually so the initial layout can be done
    [self setFrame:self.frame];

    // setup the layer positions
    [self positionLayersAndMask];
}

#pragma mark -
#pragma mark Setup Frame/Layout
- (void)sizeToFit
{
    [super sizeToFit];

    NSString *onString = _toggleLayer.onString;
    NSString *offString = _toggleLayer.offString;

    CGFloat width = [onString sizeWithFont:_toggleLayer.labelFont].width;
    CGFloat offWidth = [offString sizeWithFont:_toggleLayer.labelFont].width;

    if (offWidth > width)
        width = offWidth;

    width += _toggleLayer.bounds.size.width * 2.;//add 2x the knob for padding

    CGRect newFrame = self.frame;
    CGFloat currentWidth = newFrame.size.width;
    newFrame.size.width = width;
    newFrame.origin.x += currentWidth - width;
    self.frame = newFrame;

    //old values for sizeToFit; keep these around for reference
//	newFrame.size.width = 77.0;
//	newFrame.size.height = 27.0;
}

- (void)useLayerMasking
{
    // turn of the manual clipping (done in toggleLayer's drawInContext:)
    _toggleLayer.clip = NO;
    _toggleLayer.drawOnTint = YES;
    [_toggleLayer setNeedsDisplay];

    // create the layer mask and add that to the toggleLayer
    _clipLayer = [CAShapeLayer layer];
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                        cornerRadius:self.bounds.size.height / 2.0];
    _clipLayer.path = clipPath.CGPath;
    _toggleLayer.mask = _clipLayer;
}

- (void)removeLayerMask
{
    // turn off the animations so the user doesn't see the changing of mask/clipping
    [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];

    // remove the layer mask (put on in useLayerMasking)
    _toggleLayer.mask = nil;

    // renable manual clipping (done in toggleLayer's drawInContext:)
    _toggleLayer.clip = YES;
    _toggleLayer.drawOnTint = self.on;
    [_toggleLayer setNeedsDisplay];
}

- (void)positionLayersAndMask
{
    // repositions the underlying toggle and the layer mask, plus the knob
    _toggleLayer.mask.position = CGPointMake(-_toggleLayer.frame.origin.x, 0.0);
    _outlineLayer.frame = CGRectMake(-_toggleLayer.frame.origin.x, 0, self.bounds.size.width, self.bounds.size.height);
    _knobLayer.frame = CGRectMake(_toggleLayer.frame.origin.x + _toggleLayer.frame.size.width / 2.0 - _knobLayer.frame.size.width / 2.0, -1, _knobLayer.frame.size.width, _knobLayer.frame.size.height);
}

#pragma mark -
#pragma mark Interaction
- (void)tapped:(UITapGestureRecognizer *)gesture
{
    if (_ignoreTap) {
        return;
    }

    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.on animated:YES];
    }
}

- (void)toggleDragged:(UIPanGestureRecognizer *)gesture
{
    CGFloat minToggleX = -_toggleLayer.frame.size.width / 2.0 + _toggleLayer.frame.size.height / 2.0;
    CGFloat maxToggleX = -1;

    if (gesture.state == UIGestureRecognizerStateBegan) {
        // setup by turning off the manual clipping of the toggleLayer and setting up a layer mask.
        [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
        [self useLayerMasking];
        [self positionLayersAndMask];
        _knobLayer.gripped = YES;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];

        // disable the animations before moving the layers
        [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];

        // darken the knob
        if (!_knobLayer.gripped) {
            _knobLayer.gripped = YES;
        }

        // move the toggleLayer using the translation of the gesture, keeping it inside the outline.
        CGFloat newX = _toggleLayer.frame.origin.x + translation.x;
        if (newX < minToggleX) {
            newX = minToggleX;
        }
        if (newX > maxToggleX) {
            newX = maxToggleX;
        }
        _toggleLayer.frame = CGRectMake(newX, _toggleLayer.frame.origin.y, _toggleLayer.frame.size.width, _toggleLayer.frame.size.height);

        // this will re-position the layer mask and knob
        [self positionLayersAndMask];

        [gesture setTranslation:CGPointZero inView:self];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        // flip the switch to on or off depending on which half it ends at
        CGFloat toggleCenter = CGRectGetMidX(_toggleLayer.frame);
        [self setOn:(toggleCenter > CGRectGetMidX(self.bounds)) animated:YES];
    }

    // send off the appropriate actions (not fully tested yet)
    CGPoint locationOfTouch = [gesture locationInView:self];
    if (CGRectContainsPoint(self.bounds, locationOfTouch)) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    }
    else {
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_ignoreTap) {
        return;
    }
    
    [super touchesBegan:touches withEvent:event];

    _knobLayer.gripped = YES;
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];

    [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
}

#pragma mark Setters/Getters

- (void)setOn:(BOOL)newOn
{
//	[self setOn:newOn animated:NO];
    [self setOn:newOn animated:NO ignoreControlEvents:YES];
}

- (void)setOn:(BOOL)newOn animated:(BOOL)animated
{
    [self setOn:newOn animated:animated ignoreControlEvents:NO];
}

- (void)setOn:(BOOL)newOn animated:(BOOL)animated ignoreControlEvents:(BOOL)ignoreControlEvents
{
    BOOL previousOn = self.on;
    on = newOn;
    _ignoreTap = YES;

    [CATransaction setAnimationDuration:0.014];
    _knobLayer.gripped = YES;

    // setup by turning off the manual clipping of the toggleLayer and setting up a layer mask.
    [self useLayerMasking];
    [self positionLayersAndMask];

    [CATransaction setCompletionBlock:^{
        [CATransaction begin];
        if (!animated) {
            [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
        }
        else {
            [CATransaction setValue:(id) kCFBooleanFalse forKey:kCATransactionDisableActions];
        }

        CGFloat minToggleX = -_toggleLayer.frame.size.width / 2.0 + _toggleLayer.frame.size.height / 2.0;
        CGFloat maxToggleX = -1;


        if (self.on) {
            _toggleLayer.frame = CGRectMake(maxToggleX,
                    _toggleLayer.frame.origin.y,
                    _toggleLayer.frame.size.width,
                    _toggleLayer.frame.size.height);
        }
        else {
            _toggleLayer.frame = CGRectMake(minToggleX, _toggleLayer.frame.origin.y, _toggleLayer.frame.size.width, _toggleLayer.frame.size.height);
        }

        if (!_toggleLayer.mask) {
            [self useLayerMasking];
            [_toggleLayer setNeedsDisplay];
        }

        [self positionLayersAndMask];

        _knobLayer.gripped = NO;

        [CATransaction setCompletionBlock:^{
            [self removeLayerMask];
            _ignoreTap = NO;

            // send the action here so it get's sent at the end of the animations
            if (previousOn != on && !ignoreControlEvents) {
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
        }];

        [CATransaction commit];
    }];
}

- (void)setOnTintColor:(UIColor *)anOnTintColor
{
    if (anOnTintColor != onTintColor) {
        onTintColor = anOnTintColor;
        _toggleLayer.onTintColor = anOnTintColor;
        [_toggleLayer setNeedsDisplay];
    }
}

- (void)setFrame:(CGRect)aFrame
{
    [super setFrame:aFrame];

    CGFloat knobRadius = self.bounds.size.height + 2.0;
    _knobLayer.frame = CGRectMake(0, 0, knobRadius, knobRadius);
    CGSize toggleSize = CGSizeMake(self.bounds.size.width * 2 - (knobRadius - 4), self.bounds.size.height);
    CGFloat minToggleX = -toggleSize.width / 2.0 + knobRadius / 2.0 - 1;
    CGFloat maxToggleX = -1;

    if (self.on) {
        _toggleLayer.frame = CGRectMake(maxToggleX, _toggleLayer.frame.origin.y, toggleSize.width, toggleSize.height);
    }
    else {
        _toggleLayer.frame = CGRectMake(minToggleX, _toggleLayer.frame.origin.y, toggleSize.width, toggleSize.height);
    }

    [self positionLayersAndMask];
}

- (void)setOnText:(NSString *)newOnText
{
    if (newOnText != onText) {
        onText = [newOnText copy];
        _toggleLayer.onString = onText;
        [_toggleLayer setNeedsDisplay];
    }
}

- (void)setOffText:(NSString *)newOffText
{
    if (newOffText != offText) {
        offText = [newOffText copy];
        _toggleLayer.offString = offText;
        [_toggleLayer setNeedsDisplay];
    }
}

@end
