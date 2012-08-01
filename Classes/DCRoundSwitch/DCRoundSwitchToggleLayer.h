//
//  DCRoundSwitchToggleLayer.h
//
//  Created by Patrick Richards on 29/06/11.
//  MIT License.
//
//  http://twitter.com/patr
//  http://domesticcat.com.au/projects
//  http://github.com/domesticcatsoftware/DCRoundSwitch
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface DCRoundSwitchToggleLayer : CALayer

@property(nonatomic, strong) UIColor *onTintColor;
@property(nonatomic, copy) NSString *onString;
@property(nonatomic, copy) NSString *offString;
@property(nonatomic, readonly) UIFont *labelFont;
@property(nonatomic, assign) BOOL drawOnTint;
@property(nonatomic, assign) BOOL clip;

- (id)initWithOnString:(NSString *)anOnString offString:(NSString *)anOffString onTintColor:(UIColor *)anOnTintColor;

@end
