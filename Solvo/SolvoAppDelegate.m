//
//  SolvoAppDelegate.m
//  Solvo
//
//  Created by Austin Bales on 5/18/11.
//  Copyright 2011 417east. All rights reserved.
//

#import "SolvoAppDelegate.h"

@implementation SolvoAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  NSWorkspace * ws = [NSWorkspace sharedWorkspace];
  NSArray * apps = [ws launchedApplications];

  NSRunLoop *runloop = [NSRunLoop currentRunLoop];
  NSTimer * minuteTimer = [NSTimer timerWithTimeInterval:720.0 target:self selector:@selector(send_save:) userInfo:nil repeats:YES];
  [minuteTimer retain];
  [runloop addTimer:minuteTimer forMode:NSRunLoopCommonModes];

  [window makeFirstResponder:self];
}

-(void)send_save:(id)sender {
  id *current_app = [NSRunningApplication currentApplication].bundleIdentifier;
  if ([current_app isEqual: @"com.adobe.Photoshop"] || [current_app isEqual: @"com.macromedia.fireworks"]) {
    CGEventRef down, up, release_command;
    down = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)1, true);//'z' keydown event
    CGEventSetFlags(down, kCGEventFlagMaskCommand);//set shift key down for above event
    CGEventPost(kCGSessionEventTap, down);//post event
    up = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)1, false);
    CGEventSetFlags(up, kCGEventFlagMaskCommand);
    CGEventPost(kCGSessionEventTap, up);
    release_command = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)55, false);
    CGEventPost(kCGSessionEventTap, release_command); 
  } else {
    NSLog(@"%@", current_app);
  }
}

- (void)keyDown:(NSEvent *)theEvent
{
  if ([theEvent respondsToSelector:@selector(keyCode)]){
    NSLog(@"%d", [theEvent keyCode]);
  }
}

- (void)flagsChanged:(NSEvent *)theEvent
{
  if ([theEvent respondsToSelector:@selector(keyCode)]){
    NSLog(@"%d", [theEvent keyCode]);
  }
}

- (void)keyUp:(NSEvent *)theEvent
{
  if ([theEvent respondsToSelector:@selector(keyCode)]){
    NSLog(@"%d", [theEvent keyCode]);
  }
}

- (BOOL)acceptsFirstResponder
{
  NSLog(@"Accepts First Responder");
  
  return YES;
  
}

- (BOOL)becomeFirstResponder
{
  NSLog(@"Become First Responder");
  
  return YES;
  
}
- (BOOL)resignFirstResponder
{
  NSLog(@"Resigns First Responder");
  return YES;
}

@end
