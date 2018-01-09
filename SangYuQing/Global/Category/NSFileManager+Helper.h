//
//  NSFileManager+Helper.h
//  HZExtensionKit
//
//  Created by History on 14-4-27.
//  Copyright (c) 2014年 History. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface NSFileManager (Helper)
+ (NSString *)cacheDirectory;
+ (BOOL)isFileExists:(NSString *)path;
+ (NSString *)documentDirectory;
+ (BOOL)createDirectoryAtPath:(NSString *)path;
+ (BOOL)deleteFileAtPath:(NSString *)path;
+ (BOOL)copyFileTo:(NSString *)to from:(NSString *)from;
+ (long long)fileSizeAtPath:(NSString *)path;
+ (CGFloat)folderSizeAtPath:(NSString *)path;
+ (void)deleteAllFilesAtFloder:(NSString *)path;
@end
