//
//  RMPresentationTests.m
//  RMDateSelectionViewController-Demo
//
//  Created by Roland Moers on 03.01.15.
//  Copyright (c) 2015 Roland Moers. All rights reserved.
//

#import <KIF/KIF.h>

@interface NSDate (Rounding)

- (NSDate *)dateByRoundingToMinutes:(NSInteger)minutes;

@end

@interface RMPresentationTests : KIFTestCase

@end

@implementation RMPresentationTests

- (void)beforeEach {
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"BlackVersion"];
    
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"BlurEffects"];
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"MotionEffects"];
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"BouncingEffects"];
}

- (void)testSelectingDate {
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"DatePicker"];
    
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[UIDatePicker class]]);
    if([datePickerAsUIView isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *datePicker = (UIDatePicker *)datePickerAsUIView;
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = 2015;
        components.month = 1;
        components.day = 3;
        components.hour = 15;
        components.minute = 12;
        components.second = 0;
        
        NSDate *preRoundingDate = [[NSCalendar currentCalendar] dateFromComponents:components];
        NSDate *roundedDate = [preRoundingDate dateByRoundingToMinutes:5];
        [datePicker setDate:roundedDate animated:NO];
    }
    
    [tester tapViewWithAccessibilityLabel:@"SelectButton"];
}

- (void)testCancelingDateSelection {
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"DatePicker"];
    
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[UIDatePicker class]]);
    if([datePickerAsUIView isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *datePicker = (UIDatePicker *)datePickerAsUIView;
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.year = 2015;
        components.month = 1;
        components.day = 3;
        components.hour = 15;
        components.minute = 12;
        components.second = 0;
        
        NSDate *preRoundingDate = [[NSCalendar currentCalendar] dateFromComponents:components];
        NSDate *roundedDate = [preRoundingDate dateByRoundingToMinutes:5];
        [datePicker setDate:roundedDate animated:NO];
    }
    
    [tester tapViewWithAccessibilityLabel:@"CancelButton"];
}

- (void)testPresentingWhiteVersionWithEnabledEffects {
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *nowButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"NowButton"];
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"DatePicker"];
    UIView *selectButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"SelectButton"];
    UIView *cancelButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"CancelButton"];
    
    XCTAssertTrue([nowButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[UIDatePicker class]]);
    XCTAssertTrue([selectButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([cancelButtonAsUIView isKindOfClass:[UIButton class]]);
    
    UIView *titleLabelContainer = [tester waitForViewWithAccessibilityLabel:@"TitleLabelContainer"];
    UIView *nowButtonContainer = [tester waitForViewWithAccessibilityLabel:@"NowButtonContainer"];
    UIView *datePickerContainer = [tester waitForViewWithAccessibilityLabel:@"DatePickerContainer"];
    UIView *selectAndCancelButtonContainer = [tester waitForViewWithAccessibilityLabel:@"SelectAndCancelButtonContainer"];
    
    XCTAssertTrue([titleLabelContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([nowButtonContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([datePickerContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([selectAndCancelButtonContainer isKindOfClass:[UIVisualEffectView class]]);
    
    //Unfortunately, it is not possible to test which kind of blur effect is used for UIVibrancyEffect
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"DateSelectionView"];
    XCTAssertTrue([dateSelectionView.motionEffects count] == 1);
    
    CGRect frame = dateSelectionView.frame;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == screenFrame.size.height - 10 - frame.size.height);
        XCTAssertTrue(frame.size.width == screenFrame.size.width);
        XCTAssertTrue(frame.size.height == 44 + 10 + 216 + 10 + 44 + 10 + titleLabelContainer.frame.size.height);
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == 0);
        XCTAssertTrue(frame.size.width == 340);
        XCTAssertTrue(frame.size.height == 44 + 10 + 216 + 10 + 44 + 10 + titleLabelContainer.frame.size.height + 20);
    }
    
    [tester tapViewWithAccessibilityLabel:@"SelectButton"];
}

- (void)testPresentingBlackVersionWithEnabledEffects {
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"BlackVersion"];
    
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *nowButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"NowButton"];
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"DatePicker"];
    UIView *selectButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"SelectButton"];
    UIView *cancelButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"CancelButton"];
    
    XCTAssertTrue([nowButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[UIDatePicker class]]);
    XCTAssertTrue([selectButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([cancelButtonAsUIView isKindOfClass:[UIButton class]]);
    
    UIView *titleLabelContainer = [tester waitForViewWithAccessibilityLabel:@"TitleLabelContainer"];
    UIView *nowButtonContainer = [tester waitForViewWithAccessibilityLabel:@"NowButtonContainer"];
    UIView *datePickerContainer = [tester waitForViewWithAccessibilityLabel:@"DatePickerContainer"];
    UIView *selectAndCancelButtonContainer = [tester waitForViewWithAccessibilityLabel:@"SelectAndCancelButtonContainer"];
    
    XCTAssertTrue([titleLabelContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([nowButtonContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([datePickerContainer isKindOfClass:[UIVisualEffectView class]]);
    XCTAssertTrue([selectAndCancelButtonContainer isKindOfClass:[UIVisualEffectView class]]);
    
    //Unfortunately, it is not possible to test which kind of blur effect is used for UIVibrancyEffect
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"DateSelectionView"];
    XCTAssertTrue([dateSelectionView.motionEffects count] == 1);
    
    [tester tapViewWithAccessibilityLabel:@"SelectButton"];
}

- (void)testPresentingWhiteVersionWithDisabledEffects {
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"BlurEffects"];
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"MotionEffects"];
    [tester setOn:NO forSwitchWithAccessibilityLabel:@"BouncingEffects"];
    
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *nowButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"NowButton"];
    UIView *datePickerAsUIView = [tester waitForViewWithAccessibilityLabel:@"DatePicker"];
    UIView *selectButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"SelectButton"];
    UIView *cancelButtonAsUIView = [tester waitForViewWithAccessibilityLabel:@"CancelButton"];
    
    XCTAssertTrue([nowButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([datePickerAsUIView isKindOfClass:[UIDatePicker class]]);
    XCTAssertTrue([selectButtonAsUIView isKindOfClass:[UIButton class]]);
    XCTAssertTrue([cancelButtonAsUIView isKindOfClass:[UIButton class]]);
    
    UIView *titleLabelContainer = [tester waitForViewWithAccessibilityLabel:@"TitleLabelContainer"];
    UIView *nowButtonContainer = [tester waitForViewWithAccessibilityLabel:@"NowButtonContainer"];
    UIView *datePickerContainer = [tester waitForViewWithAccessibilityLabel:@"DatePickerContainer"];
    UIView *selectAndCancelButtonContainer = [tester waitForViewWithAccessibilityLabel:@"SelectAndCancelButtonContainer"];
    
    XCTAssertTrue([titleLabelContainer isKindOfClass:[UIView class]]);
    XCTAssertTrue([nowButtonContainer isKindOfClass:[UIView class]]);
    XCTAssertTrue([datePickerContainer isKindOfClass:[UIView class]]);
    XCTAssertTrue([selectAndCancelButtonContainer isKindOfClass:[UIView class]]);
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"DateSelectionView"];
    XCTAssertTrue([dateSelectionView.motionEffects count] == 0);
    
    [tester tapViewWithAccessibilityLabel:@"SelectButton"];
}

- (void)testPresentingInLandscape {
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester waitForTimeInterval:0.5];
    
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"DateSelectionView"];
    UIView *titleLabelContainer = [tester waitForViewWithAccessibilityLabel:@"TitleLabelContainer"];
    
    CGRect frame = dateSelectionView.frame;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == screenFrame.size.height - 10 - frame.size.height);
        XCTAssertTrue(frame.size.width == screenFrame.size.width);
        XCTAssertTrue(frame.size.height == 44 + 10 + 162 + 10 + 44 + 10 + titleLabelContainer.frame.size.height);
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == 0);
        XCTAssertTrue(frame.size.width == 340);
        XCTAssertTrue(frame.size.height == 44 + 10 + 216 + 10 + 44 + 10 + titleLabelContainer.frame.size.height + 20);
    }
    
    [tester tapViewWithAccessibilityLabel:@"SelectButton"];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
}

- (void)testPresentingInPortraitAndRotatingToLandscape {
    [tester tapViewWithAccessibilityLabel:@"ShowDateSelection"];
    
    UIView *dateSelectionView = [tester waitForViewWithAccessibilityLabel:@"DateSelectionView"];
    UIView *titleLabelContainer = [tester waitForViewWithAccessibilityLabel:@"TitleLabelContainer"];
    
    CGRect frame = dateSelectionView.frame;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == screenFrame.size.height - 10 - frame.size.height);
        XCTAssertTrue(frame.size.width == screenFrame.size.width);
        XCTAssertTrue(frame.size.height == 44 + 10 + 216 + 10 + 44 + 10 + titleLabelContainer.frame.size.height);
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == 0);
        XCTAssertTrue(frame.size.width == 340);
        XCTAssertTrue(frame.size.height == 44 + 10 + 216 + 10 + 44 + 10 + titleLabelContainer.frame.size.height + 20);
    }
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationLandscapeLeft];
    [tester waitForTimeInterval:0.5];
    
    frame = dateSelectionView.frame;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == screenFrame.size.height - 10 - frame.size.height);
        XCTAssertTrue(frame.size.width == screenFrame.size.width);
        XCTAssertTrue(frame.size.height == 44 + 10 + 162 + 10 + 44 + 10 + titleLabelContainer.frame.size.height); //For some reason the frame is off by 54 pixels. TODO: Fix that!
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        XCTAssertTrue(frame.origin.x == 0);
        XCTAssertTrue(frame.origin.y == 0);
        XCTAssertTrue(frame.size.width == 340);
        XCTAssertTrue(frame.size.height == 44 + 10 + 216 + 10 + 44 + 10 + titleLabelContainer.frame.size.height + 20);
    }
    
    [tester tapViewWithAccessibilityLabel:@"SelectButton"];
    
    [system simulateDeviceRotationToOrientation:UIDeviceOrientationPortrait];
    [tester waitForTimeInterval:0.5];
}

@end